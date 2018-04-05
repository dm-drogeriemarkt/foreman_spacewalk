module ForemanSpacewalk
  class Engine < ::Rails::Engine
    engine_name 'foreman_spacewalk'

    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/helpers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/lib"]

    # Add any db migrations
    initializer 'foreman_spacewalk.load_app_instance_data' do |app|
      ForemanSpacewalk::Engine.paths['db/migrate'].existent.each do |path|
        app.config.paths['db/migrate'] << path
      end
    end

    initializer 'foreman_spacewalk.register_plugin', before: :finisher_hook do |_app|
      Foreman::Plugin.register :foreman_spacewalk do
        requires_foreman '>= 1.17'

        spacewalk_proxy_options = {
          feature: 'Spacewalk',
          label: N_('Spacewalk Proxy'),
          description: N_('Spacewalk Proxy to use to manage repositories for this host'),
          api_description: N_('ID of Spacewalk proxy to use to manage repositories for this host')
        }

        # add monitoring smart proxy to hosts and hostgroups
        smart_proxy_for Host::Managed, :spacewalk_proxy, spacewalk_proxy_options
        smart_proxy_for Hostgroup, :spacewalk_proxy, spacewalk_proxy_options

        # Extend built in permissions
        Foreman::AccessControl.permission(:edit_hosts).actions.concat [
          'foreman_spacewalk/hosts/select_multiple_spacewalk_proxy',
          'foreman_spacewalk/hosts/update_multiple_spacewalk_proxy'
        ]
      end
    end

    # Include concerns in this config.to_prepare block
    config.to_prepare do
      begin
        ::Host::Managed.send(:include, ForemanSpacewalk::HostExtensions)
        ::Hostgroup.send(:include, ForemanSpacewalk::HostgroupExtensions)
        ::HostsHelper.send(:include, ForemanSpacewalk::HostsHelperExt)
      rescue StandardError => e
        Rails.logger.warn "ForemanSpacewalk: skipping engine hook (#{e})"
      end
    end

    rake_tasks do
      Rake::Task['db:seed'].enhance do
        ForemanSpacewalk::Engine.load_seed
      end
    end
  end
end

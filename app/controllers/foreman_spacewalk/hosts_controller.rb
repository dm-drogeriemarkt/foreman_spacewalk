module ForemanSpacewalk
  class HostsController < ::HostsController
    before_action :validate_multiple_spacewalk_proxy, only: :update_multiple_spacewalk_proxy
    before_action :find_multiple, only: %i[select_multiple_spacewalk_proxy update_multiple_spacewalk_proxy]

    def validate_multiple_spacewalk_proxy
      validate_multiple_proxy(select_multiple_spacewalk_proxy_hosts_path)
    end

    def select_multiple_spacewalk_proxy; end

    def update_multiple_spacewalk_proxy
      update_multiple_proxy(_('Spacewalk'), :spacewalk_proxy=)
    end

    private

    def action_permission
      case params[:action]
      when 'select_multiple_spacewalk_proxy', 'update_multiple_spacewalk_proxy'
        :edit
      else
        super
      end
    end
  end
end

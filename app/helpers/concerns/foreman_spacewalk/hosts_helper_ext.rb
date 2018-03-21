module ForemanSpacewalk
  module HostsHelperExt
    extend ActiveSupport::Concern

    included do
      alias_method_chain :multiple_actions, :spacewalk
    end

    def multiple_actions_with_spacewalk
      spacewalk_multiple_actions = []
      if authorized_for(controller: :hosts, action: :select_multiple_downtime)
        spacewalk_multiple_actions << [
          _('Change Spacewalk Proxy'), select_multiple_spacewalk_proxy_hosts_path
        ]
      end
      multiple_actions_without_spacewalk + spacewalk_multiple_actions
    end
  end
end

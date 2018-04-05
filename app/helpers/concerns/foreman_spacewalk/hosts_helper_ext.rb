module ForemanSpacewalk
  module HostsHelperExt
    extend ActiveSupport::Concern

    module Overrides
      def multiple_actions
        spacewalk_multiple_actions = []
        if authorized_for(controller: :hosts, action: :select_multiple_downtime)
          spacewalk_multiple_actions << [
            _('Change Spacewalk Proxy'), select_multiple_spacewalk_proxy_hosts_path
          ]
        end
        super + spacewalk_multiple_actions
      end
    end

    included do
      prepend Overrides
    end
  end
end

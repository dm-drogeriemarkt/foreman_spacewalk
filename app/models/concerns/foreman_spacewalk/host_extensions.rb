module ForemanSpacewalk
  module HostExtensions
    extend ActiveSupport::Concern

    module Overrides
      def hostgroup_inherited_attributes
        super + ['spacewalk_proxy_id']
      end

      def smart_proxy_ids
        ids = super
        [spacewalk_proxy, hostgroup.try(:spacewalk_proxy)].compact.each do |proxy|
          ids << proxy.id
        end
        ids
      end
    end

    included do
      include Orchestration::Spacewalk
      prepend Overrides
    end
  end
end

module ForemanSpacewalk
  module HostExtensions
    extend ActiveSupport::Concern

    included do
      include Orchestration::Spacewalk

      alias_method_chain :smart_proxy_ids, :spacewalk_proxy
      alias_method_chain :hostgroup_inherited_attributes, :spacewalk
    end

    def hostgroup_inherited_attributes_with_spacewalk
      hostgroup_inherited_attributes_without_spacewalk + ['spacewalk_proxy_id']
    end

    def smart_proxy_ids_with_spacewalk_proxy
      ids = smart_proxy_ids_without_spacewalk_proxy
      [spacewalk_proxy, hostgroup.try(:spacewalk_proxy)].compact.each do |proxy|
        ids << proxy.id
      end
      ids
    end
  end
end

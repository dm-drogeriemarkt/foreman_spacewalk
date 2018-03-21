module ForemanSpacewalk
  module HostgroupExtensions
    extend ActiveSupport::Concern

    def spacewalk_proxy
      return super unless ancestry.present?
      SmartProxy.find_by_id(inherited_spacewalk_proxy_id)
    end

    def inherited_spacewalk_proxy_id
      return spacewalk_proxy_id unless ancestry.present?
      self[:spacewalk_proxy_id] ||
        self.class.sort_by_ancestry(
          ancestors.where('spacewalk_proxy_id is not NULL')
        ).last.try(:spacewalk_proxy_id)
    end
  end
end

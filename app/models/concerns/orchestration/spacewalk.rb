module Orchestration
  module Spacewalk
    extend ActiveSupport::Concern

    included do
      after_build :remove_spacewalk_object_for_rebuild
      before_destroy :queue_spacewalk_destroy
    end

    def spacewalk?
      spacewalk_proxy.present?
    end

    protected

    def initialize_spacewalk
      return unless spacewalk?
      @spacewalk_api = ProxyAPI::Spacewalk.new(url: spacewalk_proxy.url)
    rescue StandardError => e
      failure _('Failed to initialize the spacewalk proxy: %s') % e, e
    end

    def remove_spacewalk_object_for_rebuild
      return unless spacewalk?
      initialize_spacewalk
      begin
        del_spacewalk
      rescue ProxyAPI::ProxyException => e
        errors.add(:base, _("Error removing host from Spacewalk: '%s'") % e.message)
      end
      errors.empty?
    end

    def queue_spacewalk_destroy
      return unless spacewalk? && errors.empty?
      queue.create(name: _('Removing Spacewalk object for %s') % self, priority: 2,
                   action: [self, :del_spacewalk])
    end

    def del_spacewalk
      initialize_spacewalk
      Rails.logger.info "Deleting Spacewalk object for #{name}"
      @spacewalk_api.delete_host(name)
    rescue StandardError => e
      failure(
        format(
          _("Failed to remove host %{name} in Spacewalk: %{message}\n "),
          name: name, message: e.message
        ), e
      )
    end

    def set_spacewalk; end
  end
end

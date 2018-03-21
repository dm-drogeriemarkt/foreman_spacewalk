module ProxyAPI
  class Spacewalk < ProxyAPI::Resource
    def initialize(args)
      @url = args[:url] + '/spacewalk'
      super args
    end

    def delete_host(hostname)
      raise Foreman::Exception, 'Missing hostname.' if hostname.blank?
      parse(delete("host/#{hostname}"))
    rescue RestClient::ResourceNotFound
      true
    rescue StandardError => e
      raise ProxyException.new(url, e, N_('Unable to delete spacewalk host object for %s') % hostname)
    end
  end
end

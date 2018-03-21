f = Feature.where(name: 'Spacewalk').first_or_create
raise "Unable to create proxy feature: #{format_errors f}" if f.nil? || f.errors.any?

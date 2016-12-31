module HasUrl
  extend ActiveSupport::Concern

  class_methods do
    def url_normalize attribute, options = { default_protocol: "http" }
      define_method "normalize_#{attribute}_as_url".to_sym do
        attribute_change = public_send("#{attribute}_change")
        new_value = attribute_change&.last
        return unless new_value

        new_value_is_missing_protocol = (new_value !~ /^A(http|ftp).*/)
        return unless new_value_is_missing_protocol

        public_send("#{attribute}=", "#{options[:default_protocol]}://#{new_value}")
      end

      before_validation "normalize_#{attribute}_as_url".to_sym
    end
  end
end

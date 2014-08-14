module Authentication
  extend ActiveSupport::Concern

  module ClassMethods
    def secure_compare(a, b)
      devise_secure_compare(a, b)
    end

    def generate_authentication_token
      generate_token(:auth_token)
    end

    private

    def devise_secure_compare(a, b)
      return false if a.blank? || b.blank? || a.bytesize != b.bytesize
      l = a.unpack "C#{a.bytesize}"
      res = 0
      b.each_byte { |byte| res |= byte ^ l.shift }
      res == 0
    end

    def generate_token(column)
      loop do
        token = devise_friendly_token
        break token unless where(column.to_sym => token).first
      end
    end

    def devise_friendly_token
      SecureRandom.urlsafe_base64(52).tr('lIO0', 'sxyz')
    end
  end
end

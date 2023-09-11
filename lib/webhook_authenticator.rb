class WebhookAuthenticator
    class << self
      def encode(payload, secret_key)
        JWT.encode(payload, secret_key, 'HS256')
      end
  
      def decode(token, secret_key)
        JWT.decode(token, secret_key, true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
end
  
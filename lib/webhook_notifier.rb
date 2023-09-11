class WebhookNotifier
    require 'net/http'
    require 'openssl'
    
  
    def self.notify(endpoint, data_entry, secret_key)
      uri = URI.parse(endpoint)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'
  
      request = Net::HTTP::Post.new(uri.path)
      request.body = { data_entry: data_entry.as_json }.to_json
      request['Content-Type'] = 'application/json'
  
      # Create the digital signature
      signature = create_signature(request.body, secret_key)
      request['X-Webhook-Signature'] = signature
  
      response = http.request(request)
  
      Rails.logger.info("Webhook notification to #{endpoint} resulted in #{response.code}: #{response.body}")
    rescue StandardError => e
      Rails.logger.error("Webhook notification to #{endpoint} failed: #{e.message}")
    end
  
    def self.create_signature(data, secret_key)
      digest = OpenSSL::Digest.new('sha256')
      hmac = OpenSSL::HMAC.hexdigest(digest, secret_key, data)
      hmac
    end
  end
  
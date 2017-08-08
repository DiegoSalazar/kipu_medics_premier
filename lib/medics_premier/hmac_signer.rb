module MedicsPremier
  # Contains HMAC signature logic
  module HmacSigner
    def md5_digest(json)
      Base64.strict_encode64 Digest::MD5.hexdigest json
    end

    def build_canonical_string(content_md5, request_uri, timestamp)
      "#{content_md5},#{request_uri},#{timestamp}"
    end

    def encode_signature(secret_key, canonical_string)
      Base64.strict_encode64 hmac(secret_key, canonical_string)
    end

    def hmac(secret_key, canonical_string)
      OpenSSL::HMAC.hexdigest 'SHA256', secret_key, canonical_string
    end

    def formatted_time(time = Time.respond_to?(:zone) ? Time.zone.now : Time.now)
      time.httpdate
    end
  end
end

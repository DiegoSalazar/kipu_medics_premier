module MedicsPremier
  # Contains HMAC signature logic
  module HmacSigner
    def md5_digest(json)
      Digest::MD5.base64digest json
    end

    def build_canonical_string(content_md5, request_uri, timestamp)
      "#{content_md5},#{request_uri},#{timestamp}"
    end

    def encode_signature(secret_key, canonical_string)
      Base64.strict_encode64 hmac(secret_key, canonical_string)
    end

    def hmac(secret_key, canonical_string)
      OpenSSL::HMAC.digest 'SHA256', secret_key, canonical_string
    end

    def formatted_time
      (Time.respond_to?(:zone) ? Time.zone.now : Time.now).httpdate
    end
  end
end

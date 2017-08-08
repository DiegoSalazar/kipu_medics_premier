module MedicsPremier
  # Performs HMAC signing of request and posts to the Medics Premier API interface
  class Client
    ACCEPT = 'application/api.myadsc.com+json;version=4'
    CONTENT_TYPE = 'application/json'
    USER_AGENT = 'Kipu_EMR'

    include HmacSigner

    def initialize(endpoint, request_uri, gateway_key, secret_key)
      @endpoint = endpoint
      @request_uri = request_uri
      @gateway_key = gateway_key
      @secret_key = secret_key
    end

    # Post patient data to the API
    # Sample JSON payload in spec/fixtures/patient.json
    def post(body)
      json = add_auth_keys(body).to_json
      md5 = md5_digest json
      timestamp = formatted_time
      canonical_string = build_canonical_string md5, @request_uri, timestamp
      signature = encode_signature @secret_key, canonical_string

      HTTParty.post url, body: json, headers: headers(md5, signature, timestamp)
    end

    private

    def url
      URI.join @endpoint, @request_uri
    end

    def headers(md5, signature, timestamp)
      {
        'Content-MD5' => md5,
        'APIAuth' => signature,
        'Request-Timestamp' => timestamp,
        'Accept' => ACCEPT,
        'Content-Type' => CONTENT_TYPE,
        'User-agent' => USER_AGENT
      }
    end

    def add_auth_keys(body)
      body['document']['headers'].merge! 'gateway_key' => @gateway_key, 'secret_key' => @secret_key
      body
    end
  end
end

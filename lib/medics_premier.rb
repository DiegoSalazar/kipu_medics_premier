require 'medics_premier/version'
require 'medics_premier/hmac_signer'
require 'medics_premier/client'
require 'httparty'
require 'openssl'
require 'base64'
require 'json'
require 'uri'

# Namespace and API Client factory
module MedicsPremier
  MissingConfig = Class.new StandardError

  ENDPOINT = ENV.fetch 'KIPU_MEDICS_PREMIER_ENDPOINT', 'https://api.myadsc.com'
  REQUEST_URI = ENV.fetch 'KIPU_MEDICS_PREMIER_REQUEST_URI', '/api/v4/edi'

  SECRET_KEY = ENV.fetch 'KIPU_MEDICS_PREMIER_SECRET_KEY' do
    raise MissingConfig, 'Missing KIPU_MEDICS_PREMIER_SECRET_KEY env var'
  end

  # Instantiates a new client instance with default config
  def self.client(endpoint: ENDPOINT, request_uri: REQUEST_URI, gateway_key: GATEWAY_KEY, secret_key: SECRET_KEY)
    Client.new endpoint, request_uri, gateway_key, secret_key
  end
end

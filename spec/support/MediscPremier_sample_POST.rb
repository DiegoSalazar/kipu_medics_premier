require 'json'
require 'base64'
require 'httparty'

# INPUT section:
ENDPOINT      = ENV.fetch 'KIPU_MEDICS_PREMIER_ENDPOINT', 'https://api.myadsc.com'
@timestamp    = Time.now.httpdate # RFC 822 standard: 'Tue, 20 Jun 2017 14:30:46 GMT'

SECRET_KEY    = ENV.fetch 'KIPU_MEDICS_PREMIER_SECRET_KEY'
@json_payload =  File.read 'spec/fixtures/patient.json'

# Code:
def patient_data_json
  patient_data = JSON.parse(@json_payload) # This is now a hash
  patient_data.to_json
end

def content_type
  'application/json'
end

def api_uri
  '/api/v4/edi'
end

def payload_md5_b64
  # binary Base64 MD5 digest of the patient data in JSON format
  Digest::MD5.base64digest(patient_data_json)
end

def canonical_string
  "#{payload_md5_b64},#{api_uri},#{@timestamp}"
end

def hmac
  # hmac encrypted hash of the canonical string using SHA1 algorithm
  OpenSSL::HMAC.digest("SHA256", SECRET_KEY, canonical_string)
end

def encoded_signature
  # encoded signature simply Base64 encodes the hmac.
  Base64.strict_encode64(hmac)
end

def headers
  {
    'Request-Timestamp' => @timestamp,
    'User-agent' => 'Kipu_EMR',
    'Accept' => 'application/api.myadsc.com+json;version=4',
    'Content-Type' => content_type,
    'Content-MD5' => payload_md5_b64,
    'APIAuth' => encoded_signature
  }
end

def url
  ENDPOINT + api_uri
end
binding.pry # debug
response = HTTParty.post( url, headers: headers, body: patient_data_json)
puts response.body
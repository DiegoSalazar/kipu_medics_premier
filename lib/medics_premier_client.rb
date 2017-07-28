require "medics_premier_client/version"

module MedicsPremierClient
  ENDPOINT = ENV.fetch 'KIPU_MEDICS_PREMIER_ENDPOINT', 'https://api.myadsc.com'
  REQUEST_URI = ENV.fetch 'KIPU_MEDICS_PREMIER_REQUEST_URI', '/api/v4/edi'
  SECRET_KEY = ENV.fetch 'KIPU_MEDICS_PREMIER_SECRET_KEY', 'O3iO1odLol0N8m5yOWBmveSDTJC2sYbE'

  # NOTE: They don't use an ACCESS_ID


end

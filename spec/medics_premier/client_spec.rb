require 'spec_helper'
require 'medics_premier'

describe MedicsPremier::Client do
  subject do
    described_class.new MedicsPremier::ENDPOINT, MedicsPremier::REQUEST_URI, MedicsPremier::GATEWAY_KEY, MedicsPremier::SECRET_KEY
  end
  let(:body) { JSON.parse File.read 'spec/fixtures/patient.json' }

  context '#post' do
    it 'returns 200 ok' do
      response = subject.post(body)
      binding.pry # debug
      expect(response).to be_success
    end
  end
end

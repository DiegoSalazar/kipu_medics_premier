require 'spec_helper'
require 'medics_premier'

describe MedicsPremier::Client do
  subject do
    described_class.new MedicsPremier::ENDPOINT, MedicsPremier::REQUEST_URI, MedicsPremier::GATEWAY_KEY, MedicsPremier::SECRET_KEY
  end
  let(:patient) { JSON.parse File.read 'spec/fixtures/patient.json' }
  let(:old_time) { (Time.now - 60*60).httpdate }

  context '#post' do
    it "returns timestamp error when the it's too old" do
      expect(subject).to receive(:formatted_time).and_return old_time
      response = subject.post patient

      expect(response.body.strip).to eq "{\"message\": {\"error\": \"Stage 1 CSP Error: The time stamp provided is not within the server's allowable request processing boundaries.\"}, \"status\": \"403 Forbidden\"}"
      expect(response).to be_forbidden
    end

    it 'returns 200 ok on successful request' do
      response = subject.post patient

      expect(response.body.strip).to start_with "{\"status\" : \"Incoming patient "
      expect(response.body.strip).to include "transfer received and placed into pending processing queue. ID: "
      expect(response).to be_success
    end
  end
end

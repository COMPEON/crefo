require 'spec_helper'

describe Crefo::Service::Request do
  subject { TestService::Request.new }

  describe 'generate_request_id' do
    it 'creates a uniq id' do
      first_id = described_class.new.__send__(:generate_request_id)
      secound_id = described_class.new.__send__(:generate_request_id)
      expect(first_id).not_to eq secound_id
    end

    it 'creates a 25 char id' do
      expect(subject.__send__(:generate_request_id).length).to eq 25
    end
  end

  describe '#send' do
    let(:response) { double(:response) }
    let(:url) { Crefo.config.endpoint }

    it 'sends the request to Crefo and returns the response' do
      expect(subject.connection).to receive(:post).with(url).and_return(response)
      expect(subject.send(url)).to eq response
    end
  end

  describe '#xml' do
    it 'xml', :timecop, :mock_config do
      expect(subject.envelope).to eq fixtures_xml('request')
    end
  end
end

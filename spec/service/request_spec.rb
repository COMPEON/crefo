require 'spec_helper'

describe Crefo::Service::Request do
  subject { TestRequest.new }

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
    let(:response) { double(:response_xml, body: response_xml) }
    let(:response_xml) { double(:response_xml) }
    let(:response_object) { double(:response_object) }

    it 'sends the request to Crefo and returns the responce' do
      expect(subject.connection).to receive(:post).and_return(response)
      expect(TestResponse).to receive(:new).with(response_xml).and_return(response_object)
      expect(subject.send).to eq response_object
    end
  end

  describe '#xml' do
    it 'xml', :timecop, :mock_config do
      expect(subject.envelope).to eq fixtures_xml('request')
    end
  end
end

require 'spec_helper'

  describe Crefo::Service::Response do
    let(:response_body) { fixtures_xml('request_envelope', strip_xml_header: true) }

    subject { TestService::Response.new(response_body) }

    describe '#body' do
      it 'returns the striped body' do
        expect(subject.body).to start_with '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope"'
        expect(subject.body).to end_with '</soap:Envelope>'
      end
    end
  end

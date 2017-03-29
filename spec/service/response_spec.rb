require 'spec_helper'

describe Crefo::Service::Response do
  let(:xml) { fixtures_xml('request_envelope', strip_xml_header: true) }
  let(:http_response) { fake_response(xml) }

  subject { TestService::Response.new(http_response) }

  describe '#body' do
    context 'with multipart response' do
      let(:http_response) { fake_response_form_vcr(:report) }
      it 'returns the body' do
        expect(subject.body).to start_with '<env:Envelope xmlns:env="http://www.w3.org/2003/05/soap-envelope"'
        expect(subject.body).to end_with '</env:Envelope>'
      end
    end

    context 'with non multipart response' do
      it 'returns the body' do
        expect(subject.body).to start_with '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope"'
        expect(subject.body).to end_with "</soap:Envelope>\n"
      end
    end
  end

  describe '#multipart?' do
    context 'with multipart response' do
      let(:http_response) { fake_response_form_vcr(:report) }
      it 'returns true' do
        expect(subject.send(:multipart?)).to be true
      end
    end

    context 'with non multipart response' do
      it 'returns false' do
        expect(subject.send(:multipart?)).to be false
      end
    end
  end

  describe '#attachments' do
      context 'with multipart response' do
      let(:http_response) { fake_response_form_vcr(:report) }
      it 'returns true' do
        attachments = subject.attachments
        expect(attachments).to be_instance_of(Array)

        attachment = attachments.first
        expect(attachment).to_not eq nil
      end
    end

    context 'with non multipart response' do
      it 'returns false' do
        expect(subject.attachments).to eq []
      end
    end
  end
end

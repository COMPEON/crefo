require 'spec_helper'

describe Crefo::Service::Search::Request, vcr: :search do
  describe 'generate_request_id' do
    it 'creates a uniq id' do
      expect(described_class.new.__send__(:generate_request_id)).not_to eq described_class.new.__send__(:generate_request_id)
    end

    it 'creates a 25 char id' do
      expect(subject.__send__(:generate_request_id).length).to eq 25
    end
  end

  describe '#send' do
    it 'sends the request to Crefo and returns the responce' do
      expect(subject.send).to be_a_instance_of Crefo::Service::Search::Response
    end
  end

  describe Crefo::Service::Response do
    subject { Crefo::Service::Search::Request.new.send }

    describe '#body' do
      it 'returns the striped body' do
        expect(subject.body).to start_with '<env:Envelope xmlns:env="http://www.w3.org/2003/05/soap-envelope"'
        expect(subject.body).to end_with '</env:Envelope>'
      end
    end

    describe '#result' do
      it 'returns the raw data' do
        company = Crefo::Service::Search::Response::Company.new '10280123456789', 'BE - TestCompany1', 'RINGLAAN 18', '8531', 'HARELBEKE', 'Belgien'
        expect(subject.result).to eq [company]
      end
    end
  end

  describe '#xml' do
    xit 'xml' do
      # allow(subject).to receive(:request_id).and_return("de5e81bef7d2f81f412a1ab17")
      expect(subject.envelope).to eq <<-XML
<?xml version="1.0"?>
<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:ns="https://onlineservice.creditreform.de/webservice/0600-0021">
  <soap:Header/>
  <soap:Body>
    <ns:searchRequest>
      <ns:header>
        <ns:communicationlanguage>#{Crefo.config.communicationlanguage}</ns:communicationlanguage>
        <ns:transmissiontimestamp>2017-01-23T11:59:56+01:00</ns:transmissiontimestamp>
        <ns:keylistversion>#{Crefo.config.keylistversion}</ns:keylistversion>
        <ns:clientapplicationname>#{Crefo.config.clientapplicationname}</ns:clientapplicationname>
        <ns:clientapplicationversion>#{Crefo.config.clientapplicationversion}</ns:clientapplicationversion>
        <ns:transactionreference>de5e81bef7d2f81f412a1ab17</ns:transactionreference>
        <ns:useraccount>#{Crefo.config.useraccount}</ns:useraccount>
        <ns:generalpassword>#{Crefo.config.generalpassword}</ns:generalpassword>
        <ns:individualpassword>#{Crefo.config.individualpassword}</ns:individualpassword>
      </ns:header>
      <ns:body>
        <ns:searchtype>SETY-1</ns:searchtype>
        <ns:companyname>BE - Testcompany1</ns:companyname>
        <ns:postcode>8531</ns:postcode>
        <ns:city>Harelbeke</ns:city>
        <ns:country>BE</ns:country>
      </ns:body>
    </ns:searchRequest>
  </soap:Body>
</soap:Envelope>
      XML
      # puts subject.to_xml
    end
  end
end

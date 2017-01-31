require 'spec_helper'

describe Crefo::XML::Request::Envelope do
  class TestRequest < Crefo::Service::Request
    self.request_name = :test

    def body
      {
        foo: 'bar',
        bar: 'foo'
      }
    end
  end

  let(:xml) { Nokogiri::XML::Builder.new }
  let(:request) { TestRequest.new }
  let(:time) { Time.now.iso8601 }

  it 'builds the request header', :timecop, :mock_config do
    document = Crefo::XML::Request::Envelope.new(request: request).build

    expect(document).to eq <<~XML
      <?xml version="1.0"?>
      <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:ns="https://onlineservice.creditreform.de/webservice/0600-0021">
        <soap:Header/>
        <soap:Body>
          <ns:testRequest>
            <ns:header>
              <ns:communicationlanguage>de</ns:communicationlanguage>
              <ns:transmissiontimestamp>#{time}</ns:transmissiontimestamp>
              <ns:keylistversion>21</ns:keylistversion>
              <ns:clientapplicationname>Crefo Ruby Client</ns:clientapplicationname>
              <ns:clientapplicationversion>0</ns:clientapplicationversion>
              <ns:transactionreference>de5e81bef7d2f81f412a1ab17</ns:transactionreference>
              <ns:useraccount>mocked_useraccount</ns:useraccount>
              <ns:generalpassword>mocked_generalpassword</ns:generalpassword>
              <ns:individualpassword>mocked_individualpassword</ns:individualpassword>
            </ns:header>
            <ns:body>
              <ns:foo>bar</ns:foo>
              <ns:bar>foo</ns:bar>
            </ns:body>
          </ns:testRequest>
        </soap:Body>
      </soap:Envelope>
    XML
  end
end

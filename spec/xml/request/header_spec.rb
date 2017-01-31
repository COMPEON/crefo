require 'spec_helper'

describe Crefo::XML::Request::Header do
  let(:xml) { Nokogiri::XML::Builder.new }
  let(:request) { double(:request, request_id: 'asdfghjkl') }
  let(:time) { Time.now.iso8601 }

  it 'builds the request header', :timecop, :mock_config do
    Crefo::XML::Request::Header.build(xml, request)

    document = xml.to_xml

    expect(document).to eq <<~XML
      <?xml version="1.0"?>
      <header>
        <communicationlanguage>de</communicationlanguage>
        <transmissiontimestamp>#{time}</transmissiontimestamp>
        <keylistversion>21</keylistversion>
        <clientapplicationname>Crefo Ruby Client</clientapplicationname>
        <clientapplicationversion>0</clientapplicationversion>
        <transactionreference>asdfghjkl</transactionreference>
        <useraccount>mocked_useraccount</useraccount>
        <generalpassword>mocked_generalpassword</generalpassword>
        <individualpassword>mocked_individualpassword</individualpassword>
      </header>
    XML
  end
end

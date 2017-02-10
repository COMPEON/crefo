require 'spec_helper'

describe Crefo::XML::Request::Header do
  let(:xml) { Nokogiri::XML::Builder.new }
  let(:request) { double(:request, request_id: 'asdfghjkl') }
  let(:time) { Time.now.iso8601 }

  it 'builds the request header', :timecop, :mock_config do
    Crefo::XML::Request::Header.build(xml, request)

    document = xml.to_xml

    expect(document).to eq fixtures_xml('request_header')
  end
end

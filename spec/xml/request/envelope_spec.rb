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

    expect(document).to eq fixtures_xml('request_envelope')
  end
end

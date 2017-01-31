require 'spec_helper'

describe Crefo::XML::Request::Header do
  let(:xml) { Nokogiri::XML::Builder.new }
  let(:nodes) do
    {
      foo: 'bar',
      bar: 'foo'
    }
  end

  it 'builds the request body' do
    Crefo::XML::Request::Body.build(xml, nodes)

    document = xml.to_xml

    expect(document).to eq <<~XML
      <?xml version="1.0"?>
      <body>
        <foo>bar</foo>
        <bar>foo</bar>
      </body>
    XML
  end
end

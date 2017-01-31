require 'spec_helper'

describe Crefo::XML::Utils::HashToNodes do
  let(:xml) { Nokogiri::XML::Builder.new }
  let(:nodes) do
    {
      foo: 'bar',
      bar: 'foo'
    }
  end

  it 'builds the request body' do
    Crefo::XML::Utils::HashToNodes.(xml, :wrapper, nodes)

    document = xml.to_xml

    expect(document).to eq <<~XML
      <?xml version="1.0"?>
      <wrapper>
        <foo>bar</foo>
        <bar>foo</bar>
      </wrapper>
    XML
  end
end

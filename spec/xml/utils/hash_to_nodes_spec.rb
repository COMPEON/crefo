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
    Crefo::XML::Utils::HashToNodes.call(xml, :wrapper, nodes)

    document = xml.to_xml

    expect(document).to eq fixtures_xml('hash_to_nodes')
  end
end

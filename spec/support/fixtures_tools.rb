module FixturesTools
  def fixtures_xml(file, strip_xml_header: nil)
    content = File.read("spec/fixtures/xmls/#{file}.xml")
    content.sub!("<?xml version=\"1.0\"?>\n", '') if strip_xml_header
    content
  end
end

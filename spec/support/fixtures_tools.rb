module FixturesTools
  def fixtures_xml(file, strip_xml_header: nil)
    content = File.read("spec/fixtures/xmls/#{file}.xml")
    content.sub!("<?xml version=\"1.0\"?>\n", '') if strip_xml_header
    content
  end

  def vcr_reponse_body(cassette_name)
    cassette = VCR.insert_cassette(cassette_name)
    data = cassette.send(:deserialized_hash)
    data["http_interactions"][0]["response"]["body"]["string"]
  end
end

module FixturesTools
  def fixtures_xml(file, strip_xml_header: false)
    content = File.read("spec/fixtures/xmls/#{file}.xml")
    content.sub!("<?xml version=\"1.0\"?>\n", '') if strip_xml_header
    content
  end

  def fake_response(body, headers = {})
    OpenStruct.new body: body, headers: headers
  end

  def fake_response_form_vcr(cassette_name)
    fake_response(vcr_response_body(cassette_name), vcr_response_headers(cassette_name))
  end

  def vcr_response_headers(cassette_name)
    data = vcr_response(cassette_name)
    data["headers"].each_with_object({}) do |(name, value), headers|
      headers[name] = value.join
    end
  end

  def vcr_response_body(cassette_name)
    data = vcr_response(cassette_name)
    data["body"]["string"]
  end

  def vcr_response(cassette_name)
    VCR.eject_cassette # TODO: fix this hack
    cassette = VCR.insert_cassette(cassette_name)
    data = cassette.send(:deserialized_hash)
    data["http_interactions"][0]["response"]
  end
end

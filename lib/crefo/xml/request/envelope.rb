module Crefo
  module XML
    class Request
      class Envelope
        attr_reader :request

        def initialize(request: raise(ArgumentError))
          @request = request
        end

        def build
          builder = Nokogiri::XML::Builder.new
          builder['soap'].Envelope(XML::Request::NAMESPACES) do |envelope|
            envelope.Header
            envelope.Body do |body|
              body['ns'].send("#{request.class.request_name}Request") do |xml|
                XML::Request::Header.build(xml, request)
                XML::Request::Body.build(xml, request.body)
              end
            end
          end
          builder.to_xml
        end
      end
    end
  end
end

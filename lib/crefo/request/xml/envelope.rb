module Crefo
  class Request
    module XML
      class Envelope
        attr_reader :request

        def initialize(request: raise(ArgumentError))
          @request = request
        end

        def build
          builder = Nokogiri::XML::Builder.new
          builder['soap'].Envelope(XML::NAMESPACES) do |envelope|
            envelope.Header
            envelope.Body do |body|
              body['ns'].send("#{request.class.request_name}Request") do |xml|
                XML::Header.build(xml, request)
                XML::Body.build(xml, request.body)
              end
            end
          end
          builder.to_xml
        end
      end
    end
  end
end

module Crefo
  class Service
    class Response
      class ParsingError < StandardError; end
      class ResponseError < StandardError; end

      attr_accessor :response_body

      def initialize(response_body = nil)
        self.response_body = response_body
      end

      def body
        @body ||= begin
          @response_body.gsub(/^-+=_Part_.+$/, '')
                        .gsub(/^Content-Type:.+$/, '')
                        .strip
        end
      end

      def document_hash
        @document_hash ||= begin
          document_hash = begin
            nori = Nori.new(strip_namespaces: true, convert_tags_to: ->(tag) { tag.to_sym })
            nori.parse(body)
          rescue
            raise ParsingError, body
          end

          raise ResponseError, Nokogiri::XML(body).to_xml if document_hash[:Envelope][:Body][:Fault]

          document_hash
        end
      end

      def document_body_hash
        document_reponse_hash[:body]
      end

      def document_reponse_hash
        document_hash[:Envelope][:Body][:"#{self.class.response_name}Response"]
      end

      def response_id
        document_reponse_hash[:header][:responseid]
      end

      class << self
        def response_name
          @response_name
        end

        def response_name=(response_name)
          @response_name = response_name
        end
      end
    end
  end
end

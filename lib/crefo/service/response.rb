module Crefo
  class Service
    class Response
      def initialize(response)
        @response = response
      end

      def body
        @body ||= begin
          @response.body
                   .gsub(/^-+=_Part_.+$/, '')
                   .gsub(/^Content-Type:.+$/, '')
                   .strip
        end
      end

      def document_hash
        @document_hash ||= begin
          nori = Nori.new(strip_namespaces: true, convert_tags_to: ->(tag) { tag.to_sym })
          nori.parse(body)
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
          @@response_name
        end

        def response_name=(response_name)
          @@response_name = response_name
        end
      end
    end
  end
end

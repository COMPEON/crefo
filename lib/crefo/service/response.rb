module Crefo
  class Service
    class Response
      class ParsingError < StandardError; end
      class ResponseError < StandardError; end

      attr_reader :body, :attachments, :document_hash

      def initialize(response)
        @response = response
        @body = ''
        @attachments = []
        parse_body
        parse_document
      end

      def document_body_hash
        document_reponse_hash[:body]
      end

      def document_reponse_hash
        document_hash[:Envelope][:Body][:"#{self.class.response_name}Response"]
      end

      def document_fault_hash
        document_hash[:Envelope][:Body][:Fault]
      end

      def response_id
        document_reponse_hash[:header][:responseid]
      end

      private

      def parse_document
        @document_hash = begin
          nori = Nori.new(strip_namespaces: true, convert_tags_to: ->(tag) { tag.to_sym })
          nori.parse(body)
        rescue
          raise ParsingError, body
        end

        raise ResponseError, Nokogiri::XML(body).to_xml if error?
      end

      def error?
        document_fault_hash
      end

      def multipart?
        !(@response.headers['content-type'] =~ /^multipart/im).nil?
      end

      def boundary
        return unless multipart?
        @boundary ||= Mail::Field.new('content-type', @response.headers['content-type']).parameters['boundary']
      end

      def parse_body
        if multipart?
          body = @response.body
          body.force_encoding(Encoding::BINARY)

          parts = body.split(/(?:\A|\r\n)(?:--#{boundary}?(?:--)?)(?=\s*$)/)
          parts = parts.map do |part|
            part.gsub(/((\r\n)?Content-.*\r\n(\r\n)?)/, '')
          end
          parts.shift

          @body = parts[0]
          @attachments = parts[1..-1]
        else
          @body = @response.body
        end
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

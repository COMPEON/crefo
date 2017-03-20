module Crefo
  class Service
    class Response
      class ParsingError < StandardError; end
      class ResponseError < StandardError; end

      attr_reader :body, :attachments, :document_hash

      def initialize(response)
        @response = response
        @body = ''
        @raw_attachments = []
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

      def attachments
        @attachments ||= @raw_attachments.map do |raw_attachment|
          Attachment.from_raw_attachment(raw_attachment)
        end
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
          parts = Mail::Part.new(
            headers: @response.headers,
            body: @response.body
          ).body.split!(boundary).parts
          @body = parts[0].body.to_s
          @raw_attachments = parts[1..-1]
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

      class Attachment
        attr_reader :type, :encoding, :id, :data

        def initialize(type, encoding, id, data)
          @type = type
          @encoding = encoding
          @id = id
          @data = data
        end

        class << self
          def from_raw_attachment(raw_attachment)
            content_type = raw_attachment.header[:content_type]
            type = content_type.sub_type || content_type.main_type
            encoding = raw_attachment.header[:content_transfer_encoding].value
            id = raw_attachment.header[:content_id].value
            data = raw_attachment.body.to_s
            new(type, encoding, id, data)
          end
        end
      end
    end
  end
end

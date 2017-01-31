require 'nokogiri'
require 'faraday'

module Crefo
  class Service
    class Request
      attr_reader :request_id

      def initialize(request_id: nil)
        @request_id = request_id || Crefo.config.transactionreference || generate_request_id
      end

      def envelope
        XML::Request::Envelope.new(request: self).build
      end

      def send
        response = connection.post Crefo.config.endpoint do |reqest|
          reqest.headers[:content_type] = 'application/xop+xml'
          reqest.body = envelope
        end
        self.class.response_class.new response
      end

      def connection
        @connection ||= begin
          options = Crefo.config.connection_options.merge(
          {}
          )
          Faraday.new(options) do |connection|
            connection.headers[:user_agent] = "#{Crefo.config.clientapplicationname} v#{Crefo.config.clientapplicationversion}"
            connection.request :multipart
            connection.adapter :net_http
          end
        end
      end

      private

      def generate_request_id
        SecureRandom.hex[0, 25]
      end

      class << self
        def response_class
          @@response_class
        end

        def response_class=(response_class)
          @@response_class = response_class
        end

        def request_name
          @@request_name
        end

        def request_name=(request_name)
          @@request_name = request_name
        end
      end
    end
  end
end

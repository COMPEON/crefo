require 'crefo/service/request'
require 'crefo/service/response'

module Crefo
  class Service
    attr_reader :options, :log

    def initialize(options = {})
      @options = options
    end

    def process
      begin
        url = Crefo.config.endpoint
        request = self.class::Request.new(options)
        response_data = request.send(url)
        response = self.class::Response.new(response_data)
        result = Result.new(
          result: response.result,
          body: response.body,
          attachments: response.attachments
        )
      rescue Crefo::Service::Response::ResponseError => exception
        error = true
      rescue Exception => exception
        error = %(#{exception.class}: #{exception.message}\n#{exception.backtrace.join("\n")})
        raise exception
      ensure
        @log = Crefo::Log.new(url, (request && request.envelope), (response && response.body), error)
        result
      end
    end

    class Result
      attr_reader :result, :body, :attachments

      def initialize(result: raise(ArgumentError), body: raise(ArgumentError), attachments: raise(ArgumentError))
        @result = result
        @body = body
        @attachments = attachments
      end
    end
  end
end

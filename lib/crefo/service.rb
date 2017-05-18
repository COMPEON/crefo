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
      rescue Crefo::Service::Response::ResponseError => exception
        error = true
      rescue Exception => exception
        error = %(#{exception.class}: #{exception.message}\n#{exception.backtrace.join("\n")})
        raise exception
      end
      
      Crefo::Log.new(url, (request && request.envelope), (response && response.body), error)
      Result.new(
        result: (response && response.result),
        body: (response && response.body),
        attachments: (response && response.attachments),
        error: error
      )
    end

    class Result
      attr_reader :result, :body, :attachments, :error

      def initialize(result: raise(ArgumentError), body: raise(ArgumentError), attachments: raise(ArgumentError), error: raise(ArgumentError))
        @result = result
        @body = body
        @attachments = attachments
        @error = error
      end
    end
  end
end

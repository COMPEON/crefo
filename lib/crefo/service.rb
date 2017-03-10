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
        response_body = request.send(url)
        response = self.class::Response.new(response_body)
        result = response.result
      rescue Crefo::Response::ResponseError => exception
        error = true
      rescue Exception => exception
        error = %(#{exception.class}: #{exception.message}\n#{exception.backtrace.join("\n")})
        raise exception
      ensure
        @log = Crefo::Log.new(url, request.envelope, response_body, error)
        result
      end
    end
  end
end

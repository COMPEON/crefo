module Crefo
  class Service
    attr_reader :options

    def initialize(options)
      @options = options
    end

    def process
      self.class::Response.new.tap do |response|
        response.response_body = self.class::Request.new(options).send
      end.result
    end
  end
end

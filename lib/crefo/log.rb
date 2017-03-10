module Crefo
  class Log
    attr_reader :url, :request, :response, :error

    def initialize(url, request, response, error)
      @url = url
      @request = request
      @response = response
      @error = error
    end

    def errored?
      !error.nil?
    end
  end
end

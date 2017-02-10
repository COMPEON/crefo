class TestService < Crefo::Service
  class Request < Crefo::Service::Request
    self.request_name = :test
    self.response_class = TestService::Response

    def body
      {
        foo: 'bar',
        bar: 'foo'
      }
    end
  end

  class Response < Crefo::Service::Response
    def result
      []
    end
  end
end

require_relative './test_response'

class TestRequest < Crefo::Service::Request
  self.request_name = :test
  self.response_class = TestResponse

  def body
    {
      foo: 'bar',
      bar: 'foo'
    }
  end
end

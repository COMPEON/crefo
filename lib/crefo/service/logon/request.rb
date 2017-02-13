module Crefo
  class Service
    class Logon < Crefo::Service
      class Request < Service::Request
        self.request_name = :logon
        self.response_class = Logon::Response

        def body
          {}
        end
      end
    end
  end
end

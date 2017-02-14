module Crefo
  class Service
    class Keylist
      class Request < Service::Request
        self.request_name = :keylist
        self.response_class = Keylist::Response

        def body
          {}
        end
      end
    end
  end
end

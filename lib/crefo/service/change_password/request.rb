module Crefo
  class Service
    class ChangePassword < Crefo::Service
      class Request < Service::Request
        self.request_name = :changepassword
        self.response_class = ChangePassword::Response

        def body
          {
            newpassword: options[:newpassword]
          }
        end
      end
    end
  end
end

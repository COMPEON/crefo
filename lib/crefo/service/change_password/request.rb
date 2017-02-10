module Crefo
  class Service
    class ChangePassword
      class Request < Service::Request
        self.request_name = :changepassword
        self.response_class = ChangePassword::Response

        def body
          {
            newpassword: 'NEW_PASSWORD'
          }
        end
      end
    end
  end
end

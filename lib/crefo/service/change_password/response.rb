module Crefo
  class Service
    class ChangePassword
      class Response < Service::Response
        self.response_name = :changepassword

        def result
          !!response_id
        end
      end
    end
  end
end

module Crefo
  class Service
    class Keylist
      class Response < Service::Response
        self.response_name = :keylist

        def result
          document_body_hash
        end
      end
    end
  end
end

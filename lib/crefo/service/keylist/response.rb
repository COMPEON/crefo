module Crefo
  class Service
    class Keylist < Crefo::Service
      class Response < Service::Response
        self.response_name = :keylist

        def result
          document_body_hash
        end
      end
    end
  end
end

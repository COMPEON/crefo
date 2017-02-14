module Crefo
  class Service
    class Logon
      class Response < Service::Response
        self.response_name = :logon

        def result
          document_body_hash
        end
      end
    end
  end
end

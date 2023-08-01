module Crefo
  class Service
    class MailboxDirectory
      class Response < Service::Response
        self.response_name = :mailboxdirectory

        def result
          document_body_hash
        end
      end
    end
  end
end

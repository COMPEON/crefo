module Crefo
  class Service
    class MailboxEntry
      class Request < Service::Request
        self.request_name = :mailboxentry
        self.response_class = MailboxEntry::Response

        def body
          {
            mailboxentrynumber: options[:mailboxentrynumber]
          }
        end
      end
    end
  end
end

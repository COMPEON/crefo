module Crefo
  class Service
    class MailboxDirectory
      class Request < Service::Request
        self.request_name = :mailboxdirectory
        self.response_class = MailboxDirectory::Response

        def body
          {
            openorders: options[:openorders] || false,
            entriesread: options[:entriesread] || false,
            entriesunread: options[:entriesunread] || true,
            deliverytypeupdate: options[:deliverytypeupdate] || true,
            deliverytypereport: options[:deliverytypereport] || true,
            deliverytypestatusreply: options[:deliverytypestatusreply] || true,
            deliverytypesupplement: options[:deliverytypesupplement] || true,
            deliverytypestockdelivery: options[:deliverytypestockdelivery] || true,
          }.merge(options)
        end
      end
    end
  end
end

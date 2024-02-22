module Crefo
  class Service
    class MailboxEntry < Crefo::Service
      def initialize(options)
        raise 'mailboxentrynumber is missing' unless options[:mailboxentrynumber]

        super(options)
      end
    end
  end
end

require 'crefo/service/mailbox_entry/response'
require 'crefo/service/mailbox_entry/request'

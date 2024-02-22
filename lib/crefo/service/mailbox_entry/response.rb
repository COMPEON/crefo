module Crefo
  class Service
    class MailboxEntry
      class Response < Service::Response
        self.response_name = :mailboxentry

        def result
          if report_not_available?
            false
          else
            document_body_hash
          end
        end

        private

        def error?
          return false unless document_fault_hash
          return false if report_not_available?

          true
        end

        def report_not_available?
          return false unless document_fault_hash
          'ER-114' == document_fault_hash&.dig(:Detail, :servicefault, :body, :fault, :errorkey, :key)
        end
      end
    end
  end
end

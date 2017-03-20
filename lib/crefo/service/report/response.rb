module Crefo
  class Service
    class Report
      class Response < Service::Response
        self.response_name = :report

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
          'ER-114' == document_fault_hash[:Detail][:servicefault][:body][:fault][:errorkey][:key]
        end
      end
    end
  end
end

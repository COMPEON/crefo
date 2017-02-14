module Crefo
  class Service
    class Report
      class Response < Service::Response
        self.response_name = :report

        def result
          document_body_hash[:reportdata][:solvencyindex][:solvencyindexone].to_i
        end
      end
    end
  end
end

module Crefo
  class Service
    class Report
      class Request < Service::Request
        self.request_name = :report
        self.response_class = Report::Response

        def body
          options
        end
      end
    end
  end
end

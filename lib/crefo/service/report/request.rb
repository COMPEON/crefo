module Crefo
  class Service
    class Report
      class Request < Service::Request
        self.request_name = :report
        self.response_class = Report::Response

        def body
          {
            identificationnumber: options[:identificationnumber],
            legitimateinterest: 'LEIN-101',
            reportlanguage: 'de',
            producttype: 'PRTY-2'
          }
        end
      end
    end
  end
end

module Crefo
  class Service
    class Search
      class Request < Service::Request
        self.request_name = :search
        self.response_class = Search::Response

        def body
          {
            searchtype: 'SETY-1',
            companyname: 'BE - Testcompany1',
            postcode: '8531',
            city: 'Harelbeke',
            country: 'BE'
          }
        end
      end
    end
  end
end

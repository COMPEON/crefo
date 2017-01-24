module Crefo
  class Request
    class Search < self
      self.request_name = :search
      self.response_class = Crefo::Response::Search

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

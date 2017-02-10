module Crefo
  class Service
    class Search
      class Response
        class Company < Struct.new(:identificationnumber, :companyname, :street, :zipcode, :city, :country); end
      end
    end
  end
end

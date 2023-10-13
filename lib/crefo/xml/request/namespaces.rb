module Crefo
  module XML
    class Request
      NAMESPACES = {
        'xmlns:soap' => 'http://www.w3.org/2003/05/soap-envelope',
        'xmlns:ns' => 'https://onlineservice.creditreform.de/webservice/0710-0033'
      }.freeze
    end
  end
end

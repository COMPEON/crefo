module Crefo
  module XML
    class Request
      class Header
        class << self
          def build(xml, request)
            nodes = {
              communicationlanguage: Crefo.config.communicationlanguage,
              transmissiontimestamp: Time.now.iso8601,
              keylistversion: Crefo.config.keylistversion,
              clientapplicationname: Crefo.config.clientapplicationname,
              clientapplicationversion: Crefo.config.clientapplicationversion,
              transactionreference: request.request_id,
              useraccount: Crefo.config.useraccount,
              generalpassword: Crefo.config.generalpassword,
              individualpassword: Crefo.config.individualpassword
            }

            HashToNodes.(xml, :header, nodes)
          end
        end
      end
    end
  end
end

module Crefo
  class Request
    module XML
      class Body
        class << self
          def build(xml, nodes)
            HashToNodes.(xml, :body, nodes)
          end
        end
      end
    end
  end
end

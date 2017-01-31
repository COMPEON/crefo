module Crefo
  module XML
    class Utils
      module HashToNodes
        def call(xml_builder, wrapper_node, nodes)
          xml_builder.__send__ wrapper_node do |parent_node|
            nodes.each_pair do |key, value|
              case value
              when Hash
                HashToNodes.call(xml_builder, key, value)
              else
                parent_node.send key, value
              end
            end
          end
        end
        module_function :call
      end
    end
  end
end

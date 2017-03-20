module Crefo
  class Service
    class Search
      class Response < Service::Response
        self.response_name = :search

        def result
          hits
        end

        # ensure that the result is always a array
        def hits
          @hits ||= begin
            object = document_body_hash[:hit]
            if object.nil?
              []
            elsif object.respond_to?(:to_ary)
              object.to_ary || [object]
            else
              [object]
            end
          end
        end
      end
    end
  end
end

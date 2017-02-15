module Crefo
  class Service
    class Report < Crefo::Service
      def initialize(options)
        raise 'identificationnumber is missing' unless options[:identificationnumber]
        raise 'legitimateinterest is missing' unless options[:legitimateinterest]
        raise 'producttype is missing' unless options[:producttype] || options[:productid]

        options[:reportlanguage] ||= Crefo.config.communicationlanguage
        options[:producttype] ||= "PRTY-#{options.delete(:productid)}"

        super(options)
      end
    end
  end
end

require 'crefo/service/report/response'
require 'crefo/service/report/request'

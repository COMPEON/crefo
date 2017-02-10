module Crefo
  class Configuration
    CURRENT_KEYLISTVERSION = 21
    ENDPOINTS = {
      default: 'https://onlineservice.creditreform.de:443/webservice/0600-0021/soap12/messages.wsdl',
      test: 'https://ktu.onlineservice.creditreform.de:443/webservice/0600-0021/soap12/messages.wsdl'
    }.freeze

    attr_accessor :communicationlanguage, :keylistversion, :transactionreference
    attr_accessor :clientapplicationname, :clientapplicationversion
    attr_accessor :useraccount, :generalpassword, :individualpassword, :connection_options
    attr_writer :endpoint

    def initialize
      @keylistversion = CURRENT_KEYLISTVERSION
      @communicationlanguage = 'de'
      @clientapplicationname = 'Crefo Ruby Client'
      @clientapplicationversion = Crefo::VERSION.to_i
      @connection_options = {}
      @endpoint = :default
    end

    def endpoint
      ENDPOINTS.fetch(@endpoint, @endpoint)
    end

    module Builder
      def configure(&block)
        config.tap(&block)
      end

      def config
        @configuration ||= Crefo::Configuration.new
      end

      module TestHelper
        def mock_config!(&block)
          @old_configuration = @configuration
          @configuration = @configuration.dup.tap(&block)
        end

        def unmock_config!
          @configuration = @old_configuration
        end

        def test_time
          Time.new(2014, 12, 20, 4, 44, 44, "+01:00")
        end
      end
    end
  end
  extend Configuration::Builder
end

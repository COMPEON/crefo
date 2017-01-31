$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'crefo'
require 'timecop'
require 'dotenv'
require 'vcr'

Dotenv.load

Crefo.configure do |config|
  config.useraccount = ENV['CREFO_USERACCOUNT']
  config.generalpassword = ENV['CREFO_GENERALPASSWORD']
  config.individualpassword = ENV['CREFO_INDIVIDUALPASSWORD']
  config.transactionreference = 'de5e81bef7d2f81f412a1ab17'
  config.endpoint = :test
  config.connection_options = {
    # proxy: 'http://localhost:8080',
    # ssl: { verify: false }
  }
end

Crefo.extend Crefo::Configuration::Builder::TestHelper

VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = true
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :faraday
  config.filter_sensitive_data('<CREFO_USERACCOUNT>') { Crefo.config.useraccount }
  config.filter_sensitive_data('<CREFO_GENERALPASSWORD>') { Crefo.config.generalpassword }
  config.filter_sensitive_data('<CREFO_INDIVIDUALPASSWORD>') { Crefo.config.individualpassword }
end

RSpec.configure do |config|
  config.filter_run :focus unless ENV['CI']
  config.filter_run_excluding :skip unless ENV['CI']
  config.run_all_when_everything_filtered = true

  config.around(:each, :vcr) do |example|
    VCR.use_cassette example.metadata[:vcr], match_requests_on: [:body, :headers] do |cassette|
      Timecop.freeze(cassette.originally_recorded_at || Time.now) do
        example.run
      end
    end
  end

  config.around(:each, :timecop) do |example|
    Timecop.freeze(Time.now) do
      example.run
    end
  end

  config.around(:each, :mock_config) do |example|
    Crefo.mock_config! do |mock|
      mock.useraccount = 'mocked_useraccount'
      mock.generalpassword = 'mocked_generalpassword'
      mock.individualpassword = 'mocked_individualpassword'
    end
    example.run
    Crefo.unmock_config!
  end
end

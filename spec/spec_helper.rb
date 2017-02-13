$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'crefo'
require 'timecop'
require 'dotenv'
require 'vcr'
require 'pry'

Dir['spec/support/*'].each do |file|
  require "#{Dir.pwd}/#{file}"
end

Dotenv.load

Crefo.configure do |config|
  config.clientapplicationname = ENV['CREFO_CLIENTAPPLICATIONNAME']
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
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :faraday
  config.filter_sensitive_data('{CREFO_CLIENTAPPLICATIONNAME}') { Crefo.config.clientapplicationname }
  config.filter_sensitive_data('{CREFO_USERACCOUNT}') { Crefo.config.useraccount }
  config.filter_sensitive_data('{CREFO_GENERALPASSWORD}') { Crefo.config.generalpassword }
  config.filter_sensitive_data('{CREFO_INDIVIDUALPASSWORD}') { Crefo.config.individualpassword }
end

RSpec.configure do |config|
  config.filter_run :focus unless ENV['CI']
  config.filter_run_excluding :skip unless ENV['CI']
  config.run_all_when_everything_filtered = true

  config.include FixturesTools

  config.around(:each, :vcr) do |example|
    VCR.eject_cassette # TODO: fix this hack

    options = { match_requests_on: [:body, :headers] }
    # options.merge!(record: :new_episodes) # use only if implementing new apis

    VCR.use_cassette example.metadata[:vcr], options do |cassette|
      Timecop.freeze(Crefo.test_time) do
        example.run
      end
    end
  end

  config.around(:each, :timecop) do |example|
    Timecop.freeze(Crefo.test_time) do
      example.run
    end
  end

  config.around(:each, :mock_config) do |example|
    Crefo.mock_config! do |mock|
      mock.clientapplicationname = 'mocked_clientapplicationname'
      mock.useraccount = 'mocked_useraccount'
      mock.generalpassword = 'mocked_generalpassword'
      mock.individualpassword = 'mocked_individualpassword'
    end
    example.run
    Crefo.unmock_config!
  end
end

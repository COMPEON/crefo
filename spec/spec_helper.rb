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
  config.transactionreference = "de5e81bef7d2f81f412a1ab17"
  config.endpoint = :test
  config.connection_options = {
    # proxy: 'http://localhost:8080',
    # ssl: { verify: false }
  }
end

VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = true
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :faraday
  config.filter_sensitive_data('<CREFO_USERACCOUNT>') { Crefo.config.useraccount }
  config.filter_sensitive_data('<CREFO_GENERALPASSWORD>') { Crefo.config.generalpassword }
  config.filter_sensitive_data('<CREFO_INDIVIDUALPASSWORD>') { Crefo.config.individualpassword }
end

RSpec.configure do |config|
  config.around(:each, :vcr) do |example|
    VCR.use_cassette example.metadata[:vcr], match_requests_on: [:body, :headers] do |cassette|
      Timecop.freeze(cassette.originally_recorded_at || Time.now) do
        example.run
      end
    end
  end
end

require 'spec_helper'

describe Crefo::Configuration do
  it 'has a current keylistversion' do
    expect(Crefo::Configuration::CURRENT_KEYLISTVERSION).to eq 21
  end

  it 'has a endpoints list' do
    expect(Crefo::Configuration::ENDPOINTS).to be_a Hash
    expect(Crefo::Configuration::ENDPOINTS).to have_key :default
    expect(Crefo::Configuration::ENDPOINTS).to have_key :test
  end

  context Crefo::Configuration do
    subject do
      Class.new do
        extend Crefo::Configuration::Builder
      end
    end

    let(:config) { subject.config }

    before(:each) do
      subject.configure do |config|
        config.endpoint = :test
        config.communicationlanguage = 'en'
        config.keylistversion = 22
        config.transactionreference = 'TEST'
        config.clientapplicationname = 'Client name'
        config.clientapplicationversion = '123'
        config.useraccount = 'user123'
        config.generalpassword = '123456'
        config.individualpassword = '7890'
        config.connection_options = { some: :options }
      end
    end

    it 'stores all configured data' do
      expect(config.endpoint).to eq 'https://ktu.onlineservice.creditreform.de:443/webservice/0600-0021/soap12/messages.wsdl'
      expect(config.communicationlanguage).to eq 'en'
      expect(config.keylistversion).to eq 22
      expect(config.transactionreference).to eq 'TEST'
      expect(config.clientapplicationname).to eq 'Client name'
      expect(config.clientapplicationversion).to eq '123'
      expect(config.useraccount).to eq 'user123'
      expect(config.generalpassword).to eq '123456'
      expect(config.individualpassword).to eq '7890'
      expect(config.connection_options).to eq(some: :options)
    end

    [
      [:default, 'https://onlineservice.creditreform.de:443/webservice/0600-0021/soap12/messages.wsdl'],
      [:test, 'https://ktu.onlineservice.creditreform.de:443/webservice/0600-0021/soap12/messages.wsdl'],
      ['http://example.com/foo.wdsl', 'http://example.com/foo.wdsl']
    ].each do |key, url|
      context "with #{key} endpoint" do
        before(:each) do
          subject.configure do |config|
            config.endpoint = key
          end
        end

        it "resolves the endpoint to #{url}" do
          expect(config.endpoint).to eq url
        end
      end
    end
  end
end

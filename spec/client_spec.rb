require 'spec_helper'

__END__

describe Crefo::Client do
  it 'has a latest keylistversion' do
    expect(Crefo::Client::LATEST_KEYLISTVERSION).to eq 21
  end

  context 'configuaration' do
    let(:default_args) do
      {
        transactionreference: 'TEST', useraccount: '123456',
        generalpassword: 'supersecret', individualpassword: 'password'
      }
    end

    it 'initialize with `:language`' do
      client = Crefo::Client.new(default_args.merge(language: 'en'))
      expect(client.language).to eq 'en'
    end

    it 'initialize without `:language`' do
      client = Crefo::Client.new(default_args)
      expect(client.language).to eq 'de'
    end

    it 'initialize with `:keylistversion`' do
      client = Crefo::Client.new(default_args.merge(keylistversion: 42))
      expect(client.keylistversion).to eq 42
    end

    it 'initialize without `:keylistversion`' do
      client = Crefo::Client.new(default_args)
      expect(client.keylistversion).to eq Crefo::Client::LATEST_KEYLISTVERSION
    end

    it 'initialize with `host: :default`' do
      client = Crefo::Client.new(default_args.merge(host: :default))
      expect(client.host).to eq 'https://onlineservice.creditreform.de:443/webservice/0600-0021/soap12/messages.wsdl'
    end

    it 'initialize with `host: :test`' do
      client = Crefo::Client.new(default_args.merge(host: :test))
      expect(client.host).to eq 'https://ktu.onlineservice.creditreform.de:443/webservice/0600-0021/soap12/messages.wsdl'
    end

    it 'initialize with `host: "http://example.com/api"`' do
      client = Crefo::Client.new(default_args.merge(host: 'http://example.com/api'))
      expect(client.host).to eq 'http://example.com/api'
    end

    it 'initialize without `:host`' do
      client = Crefo::Client.new(default_args)
      expect(client.host).to eq 'https://onlineservice.creditreform.de:443/webservice/0600-0021/soap12/messages.wsdl'
    end

    it 'initialize with `:transactionreference`' do
      client = Crefo::Client.new(default_args)
      expect(client.transactionreference).to eq 'TEST'
    end

    it 'raises ArgumentError without `:transactionreference`' do
      default_args.delete(:transactionreference)
      allow(SecureRandom).to receive(:hex).and_return("c01fa02973229cd259a36da00fc2a21e")
      client = Crefo::Client.new(default_args)
      expect(client.transactionreference).to eq "c01fa02973229cd259a36da00fc2a21e"
    end

    it 'initialize with `:useraccount`' do
      client = Crefo::Client.new(default_args)
      expect(client.useraccount).to eq '123456'
    end

    it 'raises ArgumentError without `:useraccount`' do
      default_args.delete(:useraccount)
      expect { Crefo::Client.new(default_args) }.to raise_error(ArgumentError)
    end

    it 'initialize with `:generalpassword`' do
      client = Crefo::Client.new(default_args)
      expect(client.generalpassword).to eq 'supersecret'
    end

    it 'raises ArgumentError without `:generalpassword`' do
      default_args.delete(:generalpassword)
      expect { Crefo::Client.new(default_args) }.to raise_error(ArgumentError)
    end

    it 'initialize with `:individualpassword`' do
      client = Crefo::Client.new(default_args)
      expect(client.individualpassword).to eq 'password'
    end

    it 'raises ArgumentError without `:individualpassword`' do
      default_args.delete(:individualpassword)
      expect { Crefo::Client.new(default_args) }.to raise_error(ArgumentError)
    end
  end
end

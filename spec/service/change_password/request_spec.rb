require 'spec_helper'

describe Crefo::Service::ChangePassword::Request, vcr: :changepassword do
  subject { described_class.new(newpassword: 'NEW_PASSWORD') }

  describe '#send' do
    it 'sends the request' do
      expect(subject.send(Crefo.config.endpoint)).to be_truthy
    end
  end

  describe '#body' do
    it 'builds the request body' do
      expect(subject.body).to eq(
        {
          newpassword: 'NEW_PASSWORD'
        }
      )
    end
  end
end

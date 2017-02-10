require 'spec_helper'

describe Crefo::Service::ChangePassword::Request, vcr: :change_password do
  describe '#send' do
    it 'sends the request' do
      expect(subject.send).to be_truthy
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

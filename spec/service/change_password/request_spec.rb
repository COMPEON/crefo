require 'spec_helper'

describe Crefo::Service::ChangePassword::Request, vcr: :changepassword do
  subject { described_class.new(newpassword: 'NEW_PASSWORD') }

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

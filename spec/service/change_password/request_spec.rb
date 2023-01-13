require 'spec_helper'

describe Crefo::Service::ChangePassword::Request, vcr: :changepassword do
  subject { described_class.new(newpassword: 'NEW_PASS') }

  describe '#body' do
    it 'builds the request body' do
      expect(subject.body).to eq(
        {
          newpassword: 'NEW_PASS'
        }
      )
    end
  end
end

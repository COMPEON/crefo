require 'spec_helper'

describe Crefo::Service::ChangePassword do
  subject { described_class.new(newpassword: 'NEW_PASSWORD') }

  describe '#process', vcr: :changepassword do
    it 'sends the request and returns a response result' do
      expect(subject.process).to eq true
    end
  end
end

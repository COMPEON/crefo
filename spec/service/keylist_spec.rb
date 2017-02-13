require 'spec_helper'

describe Crefo::Service::Keylist, vcr: :keylist do
  subject { described_class.new }

  describe '#process' do
    it 'sends the request and returns a response result' do
      expect(subject.process).to have_key :keylist
    end
  end
end

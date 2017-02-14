require 'spec_helper'

describe Crefo::Service::Report, vcr: :report do
  subject { described_class.new(identificationnumber: '1033123456') }

  describe '#process' do
    it 'sends the request and returns a response result' do
      expect(subject.process).to eq 400
    end
  end
end

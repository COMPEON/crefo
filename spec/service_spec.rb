require 'spec_helper'

describe Crefo::Service do
  subject(:described_class) { TestService }
  subject { described_class.new(options) }

  let(:options) { { foo: :bar } }

  describe '#initialize' do
    it 'stores the options' do
      expect(subject.options).to eq options
    end
  end

  describe '#process' do
    let(:response_body) { double(:response_body) }
    let(:result) { double(:result) }

    it 'sends the request and returns a response result' do
      expect(described_class::Request).to receive(:new).with(options).and_call_original
      expect_any_instance_of(described_class::Request).to receive(:send).and_return(response_body)
      expect_any_instance_of(described_class::Response).to receive(:response_body=).with(response_body)
      expect_any_instance_of(described_class::Response).to receive(:result).and_return(result)
      expect(subject.process).to eq result
    end
  end
end

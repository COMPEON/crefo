require 'spec_helper'

describe Crefo::Service::Search::Response do
  let(:response_body) { vcr_reponse_body(:search) }

  subject { described_class.new(response_body) }

  describe '#result' do
    it 'returns the result objects' do
      company = Crefo::Service::Search::Response::Company.new '10280123456789', 'BE - TestCompany1', 'RINGLAAN 18', '8531', 'HARELBEKE', 'Belgien'
      expect(subject.result).to eq [company]
    end

    it 'returns the result objects' do
      company = Crefo::Service::Search::Response::Company.new '10280123456789', 'BE - TestCompany1', 'RINGLAAN 18', '8531', 'HARELBEKE', 'Belgien'
      expect(subject.result).to eq [company]
    end
  end
end

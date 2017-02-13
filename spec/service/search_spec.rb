require 'spec_helper'

describe Crefo::Service::Search, vcr: :search do
  subject { described_class.new(args) }

  describe '#process' do
    context 'single result' do
      let(:args) { { companyname: "BE - Testcompany1", postcode: "8531", city: "Harelbeke", country: "BE" } }
      let(:company1) { Crefo::Service::Search::Response::Company.new('10280123456789', 'BE - TestCompany1', 'RINGLAAN 18', '8531', 'HARELBEKE', 'Belgien') }

      it 'sends the request and returns a response result' do
        expect(subject.process).to eq [company1]
      end
    end

    context 'multi result' do
      let(:args) { { companyname: 'FR - TestCompany1', postcode: '75004', country: 'FR' } }
      let(:company1) { Crefo::Service::Search::Response::Company.new('1011211311411', 'FR - TESTCOMPANY101', '74 RUE DE REIMS', '75007', 'PARIS', 'Frankreich') }
      let(:company2) { Crefo::Service::Search::Response::Company.new('1011211311412', 'FR - TESTCOMPANY1', '10 PLACE GEORGES POMPIDOU', '75004 ', 'PARIS', 'Frankreich') }

      it 'sends the request and returns a response result' do
        expect(subject.process.to_s).to eq [company1, company2].to_s
      end
    end
  end
end

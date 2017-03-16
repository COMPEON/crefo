require 'spec_helper'

describe Crefo::Service::Search, vcr: :search do
  subject { described_class.new(args) }

  describe '#process' do
    context 'single result' do
      let(:args) { { companyname: "BE - Testcompany1", postcode: "8531", city: "Harelbeke", country: "BE" } }

      it 'sends the request and returns a response result' do
        expect(subject.process.result).to eq [
          {
            identificationnumber: '10280123456789',
            companyname: 'BE - TestCompany1',
            street: 'RINGLAAN 18',
            postcode: '8531',
            city: 'HARELBEKE',
            country: 'Belgien',
            country_iso: 'BE'
          }
        ]
      end
    end

    context 'multi result' do
      let(:args) { { companyname: 'FR - TestCompany1', postcode: '75004', country: 'FR' } }

      it 'sends the request and returns a response result' do
        expect(subject.process.result).to eq [
          {
            identificationnumber: '1011211311411',
            companyname: 'FR - TESTCOMPANY101',
            street: '74 RUE DE REIMS',
            postcode: '75007',
            city: 'PARIS',
            country: 'Frankreich',
            country_iso: 'FR'
          },
          {
            identificationnumber: '1011211311412',
            companyname: 'FR - TESTCOMPANY1',
            street: '10 PLACE GEORGES POMPIDOU',
            postcode: '75004 ',
            city: 'PARIS',
            country: 'Frankreich',
            country_iso: 'FR'
          }
        ]
      end
    end
  end
end

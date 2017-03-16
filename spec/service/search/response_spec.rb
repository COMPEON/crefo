require 'spec_helper'

describe Crefo::Service::Search::Response do
  let(:response_body) { fake_response_form_vcr(:search) }

  subject { described_class.new(response_body) }

  describe '#result' do
    it 'returns the result objects' do
      expect(subject.result).to eq [
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
end

require 'spec_helper'

describe Crefo::Service::Search::Request, vcr: :search do
  subject { described_class.new(companyname: "BE - Testcompany1", postcode: "8531", city: "Harelbeke", country: "BE") }

  describe '#send' do
    it 'sends the request' do
      expect(subject.send(Crefo.config.endpoint)).to be_truthy
    end
  end

  describe '#body' do
    it 'builds the request body' do
      expect(subject.body).to eq(
        {
          searchtype: 'SETY-1',
          companyname: 'BE - Testcompany1',
          postcode: '8531',
          city: 'Harelbeke',
          country: 'BE'
        }
      )
    end
  end
end

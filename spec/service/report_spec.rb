require 'spec_helper'

describe Crefo::Service::Report, vcr: :report do
  let(:options) do
    {
      identificationnumber: '03453452013699',
      legitimateinterest: 'LEIN-101',
      productid: productid
    }
  end

  subject { described_class.new(options) }

  context 'trafficlightsolvency' do
    let(:productid) { 4 }

    describe '#process' do
      it 'sends the request and returns a response result' do
        result = subject.process.result
        expect(result).to include(
          producttype: hash_including(
            designation: 'Ampelauskunft'
          )
        )
        expect(result).to include(
          reportdata: hash_including(
            trafficlightsolvency: hash_including(
              colour: hash_including(
                designation: 'grün'
              )
            )
          )
        )
      end
    end
  end

  context 'solvencyindex' do
    let(:productid) { 3 }

    describe '#process' do
      it 'sends the request and returns a response result' do
        result = subject.process.result
        expect(result).to include(
          producttype: hash_including(
            designation: 'Kompaktauskunft'
          )
        )
        expect(result).to include(
          reportdata: hash_including(
            solvencyindex: hash_including(
              solvencyindexone: "239"
            )
          )
        )
      end
    end
  end
end

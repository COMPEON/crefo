require 'spec_helper'

describe Crefo do
  it 'has a version number' do
    expect(Crefo::VERSION).not_to be nil
  end

  it 'is extended by Configuration::Builder' do
  	expect(Crefo).to respond_to :configure
  	expect(Crefo).to respond_to :config
  end
end

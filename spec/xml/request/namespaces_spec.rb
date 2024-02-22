require 'spec_helper'

describe Crefo::XML::Request::NAMESPACES do
  it 'to have namespace soap' do
    is_expected.to include('xmlns:soap' => 'http://www.w3.org/2003/05/soap-envelope')
  end

  it 'to have namespace ns' do
    is_expected.to include('xmlns:ns' => 'https://onlineservice.creditreform.de/webservice/0710-0033')
  end
end

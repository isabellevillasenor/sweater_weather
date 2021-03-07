require 'rails_helper'

describe MapQuestFacade do
  describe 'class methods' do
    it '.get_coords' do
      json_response = File.read('spec/fixtures/mapquest_search.json')
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=77q0NrAHnIZb2b5TMhYt3zI7cldGCoRC&location=Denver,CO").with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v1.3.0'
          }).
      to_return(status: 200, body: json_response, headers: {})

      response = MapQuestFacade.get_coords('Denver,CO')

      expect(response).to be_a Hash
      expect(response.count).to eq(2)

      expect(response[:lat]).to be_a Float
      expect(response[:lat]).to eq(39.738453)

      expect(response[:lng]).to be_a Float
      expect(response[:lng]).to eq(-104.984853)
    end
  end
end

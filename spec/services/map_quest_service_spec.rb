require 'rails_helper'

describe MapQuestService do
  describe 'class methods' do
    it '.get_coords' do
      json_response = File.read('spec/fixtures/mapquest_search.json')
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAPQUEST_API_KEY']}&location=Denver,CO").with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v1.3.0'
          }).
      to_return(status: 200, body: json_response, headers: {})

      response = MapQuestService.get_coords('Denver,CO')

      expect(response).to be_a Hash
      expect(response.count).to eq(3)

      expect(response[:results][0][:locations][0][:latLng]).to be_a Hash
      expect(response[:results][0][:locations][0][:latLng][:lat]).to be_a Float
      expect(response[:results][0][:locations][0][:latLng][:lng]).to be_a Float
    end

    it '.travel_time' do
      json_response = File.read('spec/fixtures/mapquest_travel_search.json')
      stub_request(:get, "http://open.mapquestapi.com/directions/v2/route?from=Denver,CO&key=#{ENV['MAPQUEST_API_KEY']}&to=Pueblo,CO").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.3.0'
           }).
         to_return(status: 200, body: json_response, headers: {})

      response = MapQuestService.travel_time('Denver,CO', 'Pueblo,CO')

      expect(response).to be_a Hash
      expect(response.count).to eq(2)

      expect(response[:route][:formattedTime]).to eq('01:44:22')
      expect(response[:route][:locations][0][:adminArea5]).to eq('Denver')
      expect(response[:route][:locations][1][:adminArea5]).to eq('Pueblo')
    end
  end
end
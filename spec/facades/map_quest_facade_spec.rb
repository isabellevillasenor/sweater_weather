require 'rails_helper'

describe MapQuestFacade do
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

      response = MapQuestFacade.get_coords('Denver,CO')

      expect(response).to be_a Hash
      expect(response.count).to eq(2)

      expect(response[:lat]).to be_a Float
      expect(response[:lat]).to eq(39.738453)

      expect(response[:lng]).to be_a Float
      expect(response[:lng]).to eq(-104.984853)
    end

    it '.travel_time' do
      json_response = File.read('spec/fixtures/mapquest_travel_search_2.json')
      stub_request(:get, "http://open.mapquestapi.com/directions/v2/route?from=Denver,CO&key=#{ENV['MAPQUEST_API_KEY']}&to=Pueblo,CO").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.3.0'
           }).
         to_return(status: 200, body: json_response, headers: {})

      weather_response = File.read('spec/fixtures/openweather_pueblo_forecast.json')
      stub_request(:get, "http://api.openweathermap.org/data/2.5/onecall?appid=2d39d6d4253ea35c67fdf1d6b563a7d5&lat=38.265427&lon=-104.610413&units=imperial").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.3.0'
           }).to_return(status: 200, body: weather_response, headers: {})

      response = MapQuestFacade.travel_time('Denver,CO', 'Pueblo,CO')

      expect(response).to be_a Travel
    end
  end
end

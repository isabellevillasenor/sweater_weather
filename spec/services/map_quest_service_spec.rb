require 'rails_helper'

describe MapQuestService do
  describe 'class methods' do
    it '.get_coords' do
      VCR.use_cassette('test2') do
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
    end

    it '.travel_time' do
      VCR.use_cassette('test3') do
        json_response = File.read('spec/fixtures/mapquest_travel_search.json')
        stub_request(:get, "https://open.mapquestapi.com/directions/v2/route?from=Sante Fe&key=77q0NrAHnIZb2b5TMhYt3zI7cldGCoRC&to=35.0772432,-106.6555564").
             with(
               headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Faraday v1.3.0'
               }).
             to_return(status: 200, body: json_response, headers: {})
        params_start = 'Sante Fe, NM'
        params_end = '35.0772432,-106.6555564'
        response = MapQuestService.travel_time('params_start', 'params_end')

        expect(response).to be_a Hash
        expect(response.count).to eq(2)

        expect(response[:route][:formattedTime]).to eq('01:01:06')
        expect(response[:route][:locations][0][:adminArea5]).to eq('Santa Fe')
        expect(response[:route][:locations][1][:adminArea5]).to eq('Albuquerque')
      end
    end
  end
end
require 'rails_helper'

describe 'Trails Controller' do
  it 'should retrieve weather information from a trail' do
    VCR.use_cassette('test') do
      VCR.use_cassette('trails') do
        VCR.use_cassette('weather') do
          get '/api/v1/trails?start=Santa+Fe&destination=Albuquerque&minimum_steps=1000'

          json_response = File.read('spec/fixtures/mapquest_travel_search.json')
          stub_request(:get, "http://open.mapquestapi.com/directions/v2/route?from=Sante Fe&key=#{ENV['MAPQUEST_API_KEY']}&to=35.0772432,-106.6555564").
              with(
                headers: {
                'Accept'=>'*/*',
                'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'User-Agent'=>'Faraday v1.3.0'
                }).
              to_return(status: 200, body: json_response, headers: {})

          expect(response).to be_successful
          expect(response.content_type).to eq('application/json')

          result = JSON.parse(response.body, symbolize_names: true)

          expect(result).to be_a Hash
          expect(result[:data][:id]).to be_nil
          expect(result[:data][:type]).to eq('trail')
          expect(result[:data][:attributes][:trail][:name]).to eq('Tingley Field')
          expect(result[:data][:attributes][:trail][:difficulty]).to eq(1)
          expect(result[:data][:attributes][:trail][:parking]).to eq('On site')
          expect(result[:data][:attributes][:trail][:loops][:'1'][:steps]).to eq(1267)
          expect(result[:data][:attributes][:forecast][:temperature]).to eq(54.4)
          expect(result[:data][:attributes][:forecast][:summary]).to eq('overcast clouds')
        end
      end
    end
  end
end
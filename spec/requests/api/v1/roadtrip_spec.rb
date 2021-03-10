require 'rails_helper'

describe 'RoadTrip Controller' do
  it 'can create a road trip' do
    VCR.use_cassette('road_trip') do
      user = create(:user)

      road_trip_params = {
        origin: 'Denver,Co',
        destination: 'Pueblo,Co',
        api_key: user.api_key
      }

      headers = { 'CONTENT_TYPE' => 'application/json'}

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(road_trip_params)

      expect(response.status).to eq(200)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][:id]).to be_nil
      expect(result[:data][:type]).to eq('road_trip')
      expect(result[:data][:attributes].count).to eq(4)
      expect(result[:data][:attributes][:start_city]).to eq('Denver,Co')
      expect(result[:data][:attributes][:end_city]).to eq('Pueblo,Co')
      expect(result[:data][:attributes]).to have_key(:travel_time)
      expect(result[:data][:attributes][:travel_time]).to be_a String
      expect(result[:data][:attributes][:weather_at_eta]).to be_a Hash
      expect(result[:data][:attributes][:weather_at_eta].count).to eq(2)
      expect(result[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(result[:data][:attributes][:weather_at_eta][:temperature]).to be_a Float
      expect(result[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
      expect(result[:data][:attributes][:weather_at_eta][:conditions]).to be_a String
    end
  end

  it 'will give an error if city fields is missing' do
    VCR.use_cassette('bad_road_trip') do
      user = create(:user)

      road_trip_params = {
        origin: '',
        destination: 'Pueblo,Co',
        api_key: user.api_key
      }

      headers = { 'CONTENT_TYPE' => 'application/json'}

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(road_trip_params)

      expect(response.status).to eq(400)
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:message]).to eq('unsuccessful')
      expect(result[:error]).to eq('Missing/Empty Fields')
    end
  end

  it 'will give an error if api_key is incorrect' do
    VCR.use_cassette('bad_road_trip') do
      user = create(:user, api_key: 'jgn983hy48thw9begh98h4539h4')

      road_trip_params = {
        origin: 'Denver,Co',
        destination: 'Pueblo,Co',
        api_key: 'abcdefguesswhatthisis'
      }

      headers = { 'CONTENT_TYPE' => 'application/json'}

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(road_trip_params)

      expect(response.status).to eq(404)
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:message]).to eq('unsuccessful')
      expect(result[:error]).to eq('Api Key Incorrect')
    end
  end
end
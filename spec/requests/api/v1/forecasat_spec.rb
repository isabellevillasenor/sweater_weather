require 'rails_helper'

describe 'Forecast Controller' do
  it 'retrives the weather for a city' do
    VCR.use_cassette('retrive_city_weather') do
      get "/api/v1/forecast?location=Denver,CO"

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      
      expect(json[:data][:id]).to be_nil
      expect(json[:data][:type]).to eq('forecast')
      expect(json[:data][:attributes].count).to eq(3)

      expect(json[:data][:attributes]).to have_key(:current_weather)
      expect(json[:data][:attributes]).to have_key(:daily_weather)
      expect(json[:data][:attributes]).to have_key(:hourly_weather)

      expect(json[:data][:attributes][:current_weather].count).to eq(10)
  
      expect(json[:data][:attributes][:daily_weather].count).to eq(5)
      expect(json[:data][:attributes][:daily_weather][0].count).to eq(7)

      expect(json[:data][:attributes][:hourly_weather].count).to eq(8)
      expect(json[:data][:attributes][:hourly_weather][0].count).to eq(4)
    end
  end

  it 'sends an error message if unable to find location/weather' do
    VCR.use_cassette('retrive_city_weather') do
      get '/api/v1/forecast?location='

      expect(response.status).to eq(404)
    end
  end
end
require 'rails_helper'

describe 'Forecast Controller' do
  it 'retrives the weather for a city' do
    json_response = File.read('spec/fixtures/mapquest_search.json')
    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAPQUEST_API_KEY']}&location=Denver,CO").with(
    headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v1.3.0'
        }).
    to_return(status: 200, body: json_response, headers: {})
    forecast_response = File.read('spec/fixtures/openweather_forecast.json')
    
    stub_request(:get, "http://api.openweathermap.org/data/2.5/onecall?appid=2d39d6d4253ea35c67fdf1d6b563a7d5&lat=39.738453&lon=-104.984853&units=imperial").
      with(
        headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v1.3.0'
        }).
      to_return(status: 200, body: forecast_response, headers: {})


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
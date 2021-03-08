require 'rails_helper'

describe TripForecast do
  it 'exists with attributes' do
    json_response = File.read('spec/fixtures/mapquest_travel_search_2.json')
    result = JSON.parse(json_response, symbolize_names: true)
    time = Time.at(result[:route][:formattedTime].to_time).to_i

    forecast_response = File.read('spec/fixtures/openweather_pueblo_forecast.json')
    forecast_result = JSON.parse(forecast_response, symbolize_names: true)

    trip_forecast = TripForecast.new(forecast_result, time)
    expect(trip_forecast.temperature).to eq(56.3)
    expect(trip_forecast.summary).to eq('clear sky')
  end
end
require 'rails_helper'

describe TrailForecast do
  it 'exists with attributes' do
    weather_response = File.read('spec/fixtures/trail_weather.json')
    result = JSON.parse(weather_response, symbolize_names: true)

    json_response = File.read('spec/fixtures/mapquest_travel_search.json')
    json_result = JSON.parse(json_response, symbolize_names: true)
    time = Time.at(json_result[:route][:formattedTime].to_time).to_i

    trail_forecast = TrailForecast.new(result, time)
  
    expect(trail_forecast).to be_a TrailForecast

    expect(trail_forecast.summary).to eq('overcast clouds')
    expect(trail_forecast.temperature).to eq(54.9)
  end
end
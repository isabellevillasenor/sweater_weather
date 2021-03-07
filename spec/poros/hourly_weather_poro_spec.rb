require 'rails_helper'

describe HourlyWeather do
  it 'exists with attributes' do
    json_response = File.read('spec/fixtures/openweather_forecast.json')
    result = JSON.parse(json_response, symbolize_names: true)

    hourly_weather = HourlyWeather.new(result[:hourly][0])

    expect(hourly_weather.time).to eq('22:00:00')
    expect(hourly_weather.temp).to eq(68.4)
    expect(hourly_weather.conditions).to eq('broken clouds')
    expect(hourly_weather.icon).to eq('04d')
  end
end
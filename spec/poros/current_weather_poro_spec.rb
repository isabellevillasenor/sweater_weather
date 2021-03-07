require 'rails_helper'

describe CurrentWeather do
  it 'exists with attributes' do
    json_response = File.read('spec/fixtures/openweather_forecast.json')
    result = JSON.parse(json_response, symbolize_names: true)

    current_weather = CurrentWeather.new(result)

    expect(current_weather.date_time).to eq('2021-03-07 22:38:29 UTC')
    expect(current_weather.sunrise).to eq('2021-03-07 13:23:38 UTC')
    expect(current_weather.sunset).to eq('2021-03-08 00:58:24 UTC')
    expect(current_weather.temperature).to eq(68.4)
    expect(current_weather.feels_like).to eq(56.4)
    expect(current_weather.humidity).to eq(12)
    expect(current_weather.uvi).to eq(0.77)
    expect(current_weather.visibility).to eq(10000)
    expect(current_weather.conditions).to eq('broken clouds')
    expect(current_weather.icon).to eq('04d')
  end
end
require 'rails_helper'

describe CurrentWeather do
  it 'exists with attributes' do
    json_response = File.read('spec/fixtures/openweather_forecast.json')
    result = JSON.parse(json_response, symbolize_names: true)

    daily_weather = DailyWeather.new(result[:daily][0])

    expect(daily_weather.date).to eq('2021-03-07')
    expect(daily_weather.sunrise).to eq('2021-03-07 13:23:38 UTC')
    expect(daily_weather.sunset).to eq('2021-03-08 00:58:24 UTC')
    expect(daily_weather.max_temp).to eq(68.4)
    expect(daily_weather.min_temp).to eq(43.4)
    expect(daily_weather.conditions).to eq('overcast clouds')
    expect(daily_weather.icon).to eq('04d')
  end
end
require 'rails_helper'

describe Forecast do
  it 'exists with attributes' do
    json_response = File.read('spec/fixtures/openweather_forecast.json')
    result = JSON.parse(json_response, symbolize_names: true)

    current = CurrentWeather.new(result)
    daily = result[:daily][0..4].map do |day|
      DailyWeather.new(day)
    end
    hourly = result[:hourly][0..7].map do |hour|
      HourlyWeather.new(hour)
    end

    forecast = Forecast.new(current, daily, hourly)

    expect(forecast.id).to be_nil
    expect(forecast.current_weather).to be_a CurrentWeather

    expect(forecast.daily_weather[0]).to be_a DailyWeather
    expect(forecast.daily_weather).to be_an Array

    expect(forecast.hourly_weather[0]).to be_a HourlyWeather
    expect(forecast.hourly_weather).to be_an Array
  end
end
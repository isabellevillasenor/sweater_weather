require 'rails_helper'

describe RoadTrip do
  it 'exists with attributes' do
    json_response = File.read('spec/fixtures/openweather_forecast.json')
    result = JSON.parse(json_response, symbolize_names: true)
    hourly_weather = HourlyWeather.new(result[:hourly][0])

    map = File.read('spec/fixtures/mapquest_directions.json')
    map_response = JSON.parse(map, symbolize_names: true)
    params = {
      origin: 'Denver,Co',
      destination: 'Pueblo,Co'
    }

    trip = RoadTrip.new(map_response, params[:origin], params[:destination], hourly_weather)

    expect(trip.start_city).to eq('Denver,Co')
    expect(trip.end_city).to eq('Pueblo,Co')
    expect(trip.travel_time).to eq('01:44:22')
    expect(trip.weather_at_eta[:temperature]).to eq(68.4)
    expect(trip.weather_at_eta[:conditions]).to eq('broken clouds')
  end
end
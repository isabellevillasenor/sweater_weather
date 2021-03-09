require 'rails_helper'

describe Trail do
  it 'exists with attributes' do
    json_response = File.read('spec/fixtures/trails.json')
    result = JSON.parse(json_response, symbolize_names: true)

    # weather_response = File.read('spec/fixtures/trail_weather.json')
    # weather_result = JSON.parse(weather_response, symbolize_names: true)
    # weather = TrailForecast.new()

    trail = Trail.new(result[:trails][0])
    # trail.add_forecast(weather)

    expect(trail).to be_a Trail

    expect(trail.trail[:name]).to eq('Tingley Field')
    expect(trail.trail[:parking]).to eq('On site')
    expect(trail.trail[:loops][:'1'][:name]).to eq('Main Loop')
    expect(trail.trail[:loops][:'1'][:distance]).to eq('0.6')
    expect(trail.trail[:loops][:'1'][:steps]).to eq(1267)
    expect(trail.forecast).to be_nil

    #will come back and add forecast to trail and test, as well as loop size more than 1
  end
end
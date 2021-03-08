require 'rails_helper'

describe Travel do
  it 'exists with attributes' do
    json_response = File.read('spec/fixtures/mapquest_travel_search.json')
    result = JSON.parse(json_response, symbolize_names: true)

    travel = Travel.new(result, 'Denver,CO', 'Pueblo,CO')

    expect(travel).to be_a Travel
    expect(travel.start).to eq('Denver,CO')
    expect(travel.destination_city).to eq('Pueblo,CO')
    expect(travel.travel_time).to eq('01:44:22')
  end
end
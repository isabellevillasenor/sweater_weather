require 'rails_helper'

describe 'Forecast Controller' do
  it 'retrives the weather for a city' do
    json_response = File.read('spec/fixtures/mapquest_search.json')
    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=77q0NrAHnIZb2b5TMhYt3zI7cldGCoRC&location=Denver,CO").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.3.0'
           }).
         to_return(status: 200, body: json_response, headers: {})

    get "/api/v1/forecast?location=Denver,CO"

    expect(response).to be_successful
    
  end
end
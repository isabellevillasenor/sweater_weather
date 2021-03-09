require 'rails_helper'

describe OpenWeatherService do
  describe 'class methods' do
    it '.get_weather' do
      VCR.use_cassette('retrieve_coord_weather') do      
        response = OpenWeatherService.get_weather(39.738453, -104.984853)

        expect(response).to be_a Hash
        expect(response.count).to eq(8)

        expect(response[:lat]).to be_a Float
        expect(response[:lat]).to eq(39.7385)

        expect(response[:lon]).to be_a Float
        expect(response[:lon]).to eq(-104.9849)

        expect(response[:current]).to be_a Hash
        expect(response[:current]).to have_key(:dt)
        expect(response[:current]).to have_key(:sunrise)
        expect(response[:current]).to have_key(:sunset)
        expect(response[:current]).to have_key(:temp)
        expect(response[:current]).to have_key(:feels_like)
        expect(response[:current]).to have_key(:humidity)
        expect(response[:current]).to have_key(:uvi)
        expect(response[:current]).to have_key(:visibility)
        expect(response[:current]).to have_key(:weather)
        expect(response[:current][:weather][0]).to have_key(:description)
        expect(response[:current][:weather][0]).to have_key(:icon)

        expect(response[:daily]).to be_an Array
        expect(response[:daily][0]).to have_key(:dt)
        expect(response[:daily][0]).to have_key(:sunrise)
        expect(response[:daily][0]).to have_key(:sunset)
        expect(response[:daily][0]).to have_key(:temp)
        expect(response[:daily][0][:temp]).to have_key(:max)
        expect(response[:daily][0][:temp]).to have_key(:min)
        expect(response[:daily][0]).to have_key(:weather)
        expect(response[:daily][0][:weather][0]).to have_key(:description)
        expect(response[:daily][0][:weather][0]).to have_key(:icon)

        expect(response[:hourly]).to be_an Array
        expect(response[:hourly][0]).to have_key(:dt)
        expect(response[:hourly][0]).to have_key(:temp)
        expect(response[:hourly][0]).to have_key(:weather)
        expect(response[:hourly][0][:weather][0]).to have_key(:description)
        expect(response[:hourly][0][:weather][0]).to have_key(:icon)
      end
    end
  end
end
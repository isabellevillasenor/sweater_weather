require 'rails_helper'

describe MapQuestService do
  describe 'class methods' do
    it '.get_coords' do
      VCR.use_cassette('service_map') do
        response = MapQuestService.get_coords('Denver,CO')

        expect(response).to be_a Hash
        expect(response.count).to eq(3)

        expect(response[:results][0][:locations][0][:latLng]).to be_a Hash
        expect(response[:results][0][:locations][0][:latLng][:lat]).to be_a Float
        expect(response[:results][0][:locations][0][:latLng][:lng]).to be_a Float
      end
    end

    it '.road_trip' do
      VCR.use_cassette('map_road_trip') do
        params = {
          origin: 'Denver,Co',
          destination: 'Pueblo,Co'
        }

        response = MapQuestService.road_trip(params)

        expect(response).to be_a Hash
        expect(response.count).to eq(2)
      end
    end
  end
end
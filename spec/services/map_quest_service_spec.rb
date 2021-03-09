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
  end
end
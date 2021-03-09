require 'rails_helper'

describe MapQuestFacade do
  describe 'class methods' do
    it '.get_coords' do
      VCR.use_cassette('facade_map') do
        response = MapQuestFacade.get_coords('Denver,CO')

        expect(response).to be_a Hash
        expect(response.count).to eq(2)

        expect(response[:lat]).to be_a Float
        expect(response[:lat]).to eq(39.738453)

        expect(response[:lng]).to be_a Float
        expect(response[:lng]).to eq(-104.984853)
      end
    end
  end
end

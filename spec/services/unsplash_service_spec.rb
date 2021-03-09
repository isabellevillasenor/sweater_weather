require 'rails_helper'

describe UnsplashService do
  describe 'class methods' do
    it '.search' do
      VCR.use_cassette('service_image') do
        response = UnsplashService.search('denver')
        expect(response).to be_a Hash

        expect(response[:results].count).to eq(1)
        expect(response[:results][0]).to have_key(:urls)
        expect(response[:results][0]).to have_key(:user)
      end
    end
  end
end
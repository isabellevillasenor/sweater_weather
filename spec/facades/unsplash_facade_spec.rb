require 'rails_helper'

describe UnsplashFacade do
  describe 'class methods' do
    it '.search' do
      VCR.use_cassette('facade_image') do
        response = UnsplashFacade.search('denver,co')

        expect(response).to be_a BackgroundImage
        expect(response.image).to be_a Hash

        expect(response.image[:location]).to be_a String
        expect(response.image[:location]).to eq('denver,co')

        expect(response.image[:image_url]).to be_a String
        expect(response.image[:image_url]).to eq('https://images.unsplash.com/photo-1605033532441-30378efcd7ef?crop=entropy&cs=srgb&fm=jpg&ixid=MnwyMTMwNjJ8MHwxfHNlYXJjaHwxfHxkZW52ZXIsY298ZW58MHx8fHwxNjE1Mjk4NDM3&ixlib=rb-1.2.1&q=85')

        expect(response.image[:credit]).to be_a Hash
        expect(response.image[:credit]).to have_key(:source)
        expect(response.image[:credit]).to have_key(:author)
        expect(response.image[:credit]).to have_key(:logo)
      end
    end
  end
end
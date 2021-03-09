require 'rails_helper'

describe UnsplashFacade do
  describe 'class methods' do
    it '.search' do
      json_response = File.read('spec/fixtures/unsplash_search.json')
      stub_request(:get, "http://api.unsplash.com/search/photos?client_id=#{ENV['UNSPLASH_API_KEY']}&query=denver&page=1&per_page=1").
        to_return(status: 200, body: json_response)

      response = UnsplashFacade.search('denver,co')

      expect(response).to be_a BackgroundImage
      expect(response.location).to be_a String
      expect(response.location).to eq('denver,co')

      expect(response.image_url).to be_a String
      expect(response.image_url).to eq('https://images.unsplash.com/photo-1599408169542-620fc453382c?crop=entropy&cs=srgb&fm=jpg&ixid=MnwyMTMwNjJ8MHwxfHNlYXJjaHwxfHxkZW52ZXJ8ZW58MHx8fHwxNjE1MjUyMTcw&ixlib=rb-1.2.1&q=85')

      expect(response.credit).to be_a Hash
      expect(response.credit).to have_key(:source)
      expect(response.credit).to have_key(:author)
      expect(response.credit).to have_key(:author_username)
      expect(response.credit).to have_key(:logo)
    end
  end
end
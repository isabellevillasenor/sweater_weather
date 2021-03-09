require 'rails_helper'

describe UnsplashService do
  describe 'class methods' do
    it '.search' do
      json_response = File.read('spec/fixtures/unsplash_search.json')
      stub_request(:get, "http://api.unsplash.com/search/photos?client_id=#{ENV['UNSPLASH_API_KEY']}&query=denver&page=1&per_page=1").
        to_return(status: 200, body: json_response)

      response = UnsplashService.search('denver')
      expect(response).to be_a Hash

      expect(response[:results].count).to eq(1)
      expect(response[:results][0]).to have_key(:urls)
      expect(response[:results][0]).to have_key(:user)
    end
  end
end
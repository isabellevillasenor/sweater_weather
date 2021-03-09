require 'rails_helper'

describe 'Images Controller' do
  it 'retrives background image based off location' do
    VCR.use_cassette('background_image') do
      get '/api/v1/backgrounds?location=denver,co'

      expect(response).to be_successful
      expect(response.content_type).to eq('application/json')
      
      result = JSON.parse(response.body, symbolize_names: true)
      
      expect(result).to be_a Hash
      expect(result[:data][:id]).to be_nil
      expect(result[:data][:type]).to eq('image')
      expect(result[:data][:attributes][:image][:location]).to eq('denver,co')
      expect(result[:data][:attributes][:image]).to have_key(:image_url)
      expect(result[:data][:attributes][:image]).to have_key(:credit)
      expect(result[:data][:attributes][:image][:credit]).to have_key(:source)
      expect(result[:data][:attributes][:image][:credit]).to have_key(:author)
      expect(result[:data][:attributes][:image][:credit]).to have_key(:logo)
    end
  end
end
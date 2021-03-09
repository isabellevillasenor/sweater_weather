require 'rails_helper'

describe BackgroundImage do
  it 'exists with attributes' do
    json_response = File.read('spec/fixtures/unsplash_search.json')
    response = JSON.parse(json_response, symbolize_names: true)

    background_image = BackgroundImage.new(response[:results][0], 'denver,co')

    expect(background_image.image).to be_a Hash

    expect(background_image.image[:location]).to eq('denver,co')
    expect(background_image.image[:image_url]).to eq('https://images.unsplash.com/photo-1599408169542-620fc453382c?crop=entropy&cs=srgb&fm=jpg&ixid=MnwyMTMwNjJ8MHwxfHNlYXJjaHwxfHxkZW52ZXJ8ZW58MHx8fHwxNjE1MjUyMTcw&ixlib=rb-1.2.1&q=85')

    expect(background_image.image[:credit]).to be_a Hash
    expect(background_image.image[:credit]).to have_key(:source)
    expect(background_image.image[:credit][:source]).to eq('https://unsplash.com/')
    expect(background_image.image[:credit]).to have_key(:author)
    expect(background_image.image[:credit][:author]).to eq('Andrew Coop')
    expect(background_image.image[:credit]).to have_key(:logo)
    expect(background_image.image[:credit][:logo]).to eq('https://unsplash.com/@andrewcoop')
  end
end
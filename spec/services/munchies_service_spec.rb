require 'rails_helper'

describe MunchiesService do
  describe 'class methods' do
    it '.get_food' do
      json_response = File.read('spec/fixtures/yelp_search.json')
      stub_request(:get, 'http://api.yelp.com/v3/businesses/search?latitude=38.265425&longitude=-104.610415&food=burger&open_at=1615228303').with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>"Bearer #{ENV['YELP_API_KEY']}",
          'User-Agent'=>'Faraday v1.3.0'
        }).to_return(status: 200, body: json_response, headers: {})

        response = MunchiesService.get_munchies('38.265425', '-104.610415', 'burger', '1615228303')

        expect(response).to be_a Hash
        expect(response.count).to eq(3)
        expect(response[:total]).to eq(83)

        expect(response[:businesses][0][:is_closed]).to be false
    end
  end
end
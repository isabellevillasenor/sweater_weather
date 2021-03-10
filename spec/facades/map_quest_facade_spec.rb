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

    it '.road_trip' do
      VCR.use_cassette('facade_map_2') do
        params = {
          origin: 'Denver,Co',
          destination: 'Pueblo,Co'
        }

        response = MapQuestFacade.road_trip(params)

        expect(response).to be_a RoadTrip
        expect(response.start_city).to eq('Denver,Co')
        expect(response.end_city).to eq('Pueblo,Co')
        expect(response.travel_time).to eq('01:44:22')
        expect(response.weather_at_eta[:temperature]).to eq(53.8)
        expect(response.weather_at_eta[:conditions]).to eq('clear sky')
      end
    end

    it '.find_time' do
      time = MapQuestFacade.find_time(Time.now).strftime('%H:%M:%S')
      expect(time).to eq('19:00:00')

      else_time = MapQuestFacade.find_time(Time.now + 30*60).strftime('%H:%M:%S')
      expect(else_time).to eq('20:00:00')
    end
  end
end

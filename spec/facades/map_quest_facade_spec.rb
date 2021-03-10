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
        expect(response.weather_at_eta[:temperature]).to eq(48.3)
        expect(response.weather_at_eta[:conditions]).to eq('scattered clouds')
      end
    end
      
      it '.find_time' do
      set_time = Time.parse('2021-03-09 20:19:39 -0700')
      time = MapQuestFacade.find_time(set_time).strftime('%H:%M:%S')
      expect(time).to eq('20:00:00')

      set_else_time = Time.parse('2021-03-09 21:19:39 -0700')
      else_time = MapQuestFacade.find_time(set_else_time + 30*60).strftime('%H:%M:%S')
      expect(else_time).to eq('22:00:00')
    end

    describe 'sad path' do
      it '.road_trip' do
        VCR.use_cassette('bad_map') do
          params = {
            origin: 'New York,Ny',
            destination: 'London,Uk'
          }
  
          response = MapQuestFacade.road_trip(params)

          expect(response.travel_time).to eq('impossible')
          expect(response.weather_at_eta).to eq({})
          expect(response.start_city).to eq('New York,Ny')
          expect(response.end_city).to eq('London,Uk')
        end
      end
    end
  end
end

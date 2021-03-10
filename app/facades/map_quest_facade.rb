class MapQuestFacade
  class << self
    def get_coords(location)
      json = MapQuestService.get_coords(location)
      json[:results][0][:locations][0][:latLng]
    end

    def road_trip(location_params)
      json = MapQuestService.road_trip(location_params)

      if json[:route][:routeError][:errorCode] == 2
        weather_at_eta = {}
        
        road_trip = RoadTrip.new(json, location_params[:origin], location_params[:destination], weather_at_eta)
      else
        weather = self.destination_weather(location_params[:destination])
        arrival_time = (Time.now + (json[:route][:realTime]))
        arrival_weather = self.hourly_destination_weather(arrival_time, weather)
        
        road_trip = RoadTrip.new(json, location_params[:origin], location_params[:destination], arrival_weather)
      end
    end
    
    def destination_weather(location)
      destination = MapQuestService.get_coords(location)
      OpenWeatherService.get_weather(destination[:results][0][:locations][0][:latLng][:lat],
                                     destination[:results][0][:locations][0][:latLng][:lng])
    end

    def hourly_destination_weather(data_time, weather)
      temp = weather[:hourly].select do |hour|
        time = (Time.at(hour[:dt])).strftime('%H:%M:%S')
        self.find_time(data_time).strftime('%H:%M:%S') == time
      end.first
      HourlyWeather.new(temp)
    end

    def find_time(data)
      if data.strftime('%M').to_i < 30
        data.beginning_of_hour
      else
        (data + 60*60).beginning_of_hour
      end
    end
  end
end
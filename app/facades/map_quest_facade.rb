class MapQuestFacade
  class << self
    def get_coords(location)
      json = MapQuestService.get_coords(location)
      json[:results][0][:locations][0][:latLng]
    end

    def travel_time(start, destination)
      json = MapQuestService.travel_time(start, destination)
      @time = Time.at(json[:route][:formattedTime].to_time).to_i
      
      if json[:info][:statuscode] = 0
        trip = Travel.new(json, start, destination)
        weather = OpenWeatherService.get_weather(json[:route][:locations][1][:displayLatLng][:lat],
                                                 json[:route][:locations][1][:displayLatLng][:lng])
        # destination_weather = HourlyWeather.new(weather[:hourly].select{|hash| hash[:dt] == @time})
        destination_weather = TripForecast.new(weather, @time)
        trip.add_forecast(destination_weather)
        trip
      end
    end
  end
end
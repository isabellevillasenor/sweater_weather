class RoadTrip
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta
  def initialize(data, start_city, end_city, weather)
    @start_city = start_city
    @end_city = end_city
    if data[:route][:routeError][:errorCode] == 2
      @travel_time = 'impossible'
      @weather_at_eta = {}
    else
      @travel_time = data[:route][:formattedTime]
      @weather_at_eta = {
        temperature: weather.temp,
        conditions: weather.conditions
      }
    end
  end
end
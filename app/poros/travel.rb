class Travel
  attr_reader :start,
              :destination_city,
              :travel_time,
              :forecast
  def initialize(data, start, destination_city)
    @start = start
    @destination_city = destination_city
    @travel_time = data[:route][:formattedTime]
    @forecast = nil
  end

  def add_forecast(forecast)
    @forecast = forecast
  end
end
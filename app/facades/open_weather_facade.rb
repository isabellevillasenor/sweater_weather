class OpenWeatherFacade
  class << self
    def get_weather(lat, lng)
      json = OpenWeatherService.get_weather(lat, lng)
      current = CurrentWeather.new(json)
      daily = json[:daily][0..4].map do |day|
        DailyWeather.new(day)
      end
      hourly = json[:hourly][0..7].map do |hour|
        HourlyWeather.new(hour)
      end

      Forecast.new(current, daily, hourly)
    end
  end 
end
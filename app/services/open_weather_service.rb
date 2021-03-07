class OpenWeatherService
  def self.get_weather(lat, lng)
    conn = Faraday.new("http://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{lng}&appid=#{ENV['OPEN_WEATHER_API_KEY']}")
    response = conn.get
    JSON.parse(response.body, symbolize_names: true)
  end
end
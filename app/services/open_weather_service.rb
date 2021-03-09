class OpenWeatherService
  def self.get_weather(lat, lng)
    conn = Faraday.new("https://api.openweathermap.org")
    response = conn.get("/data/2.5/onecall?lat=#{lat}&lon=#{lng}&appid=#{ENV['OPEN_WEATHER_API_KEY']}&units=imperial")
    JSON.parse(response.body, symbolize_names: true)
  end
end
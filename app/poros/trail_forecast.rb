class TrailForecast
  attr_reader :temperature,
              :summary
  def initialize(weather, time)
    @time = time
    @temperature = find_weather(weather).round(1)
    @summary = find_summary(weather)
  end

  def find_weather(weather)
    temperature = weather[:hourly].select{|hash| hash[:dt] == @time}
    temperature[0][:temp]
  end

  def find_summary(weather)
    summary = weather[:hourly].select{|hash| hash[:dt] == @time}
    summary[0][:weather][0][:description]
  end
end
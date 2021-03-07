class HourlyWeather
  attr_reader :time,
              :temp,
              :conditions,
              :icon
  def initialize(data)
    @time = Time.zone.at(data[:hourly][0][:dt]).strftime('%H:%M:%S')
    @temp = data[:hourly][0][:temp].round(1)
    @conditions = data[:hourly][0][:weather][0][:description]
    @icon = data[:hourly][0][:weather][0][:icon]
  end
end
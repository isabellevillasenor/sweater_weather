class HourlyWeather
  attr_reader :time,
              :temp,
              :conditions,
              :icon
  def initialize(data)
    @time = Time.zone.at(data[:dt]).strftime('%H:%M:%S')
    @temp = data[:temp].round(1)
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end
end
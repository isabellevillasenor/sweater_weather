class DailyWeather
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon
  def initialize(data)
    @date = Time.zone.at(data[:dt]).to_date.to_s
    @sunrise = Time.zone.at(data[:sunrise]).to_s
    @sunset = Time.zone.at(data[:sunset]).to_s
    @max_temp = data[:temp][:max].round(1)
    @min_temp = data[:temp][:min].round(1)
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end
end
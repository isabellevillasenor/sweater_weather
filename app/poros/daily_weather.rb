class DailyWeather
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon
  def initialize(data)
    @date = Time.zone.at(data[:daily][0][:dt]).to_date.to_s
    @sunrise = Time.zone.at(data[:daily][0][:sunrise]).to_s
    @sunset = Time.zone.at(data[:daily][0][:sunset]).to_s
    @max_temp = data[:daily][0][:temp][:max].round(1)
    @min_temp = data[:daily][0][:temp][:min].round(1)
    @conditions = data[:daily][0][:weather][0][:description]
    @icon = data[:daily][0][:weather][0][:icon]
  end
end
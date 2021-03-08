class CurrentWeather
  attr_reader :date_time,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon
  def initialize(data)
    @date_time = Time.zone.at(data[:current][:dt]).to_s
    @sunrise = Time.zone.at(data[:current][:sunrise]).to_s
    @sunset = Time.zone.at(data[:current][:sunset]).to_s
    @temperature = data[:current][:temp].round(1)
    @feels_like = data[:current][:feels_like].round(1)
    @humidity = data[:current][:humidity]
    @uvi = data[:current][:uvi]
    @visibility = data[:current][:visibility]
    @conditions = data[:current][:weather][0][:description]
    @icon = data[:current][:weather][0][:icon]
  end
end
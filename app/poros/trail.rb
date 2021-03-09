class Trail
  attr_reader :trail, :forecast
  def initialize(data)
    @trail = {
              id: data[:id],
              name: data[:name],
              difficulty: data[:difficulty],
              parking: data[:parking],
              loops: data[:loops],
            }
      @forecast = nil
  end

  def add_forecast(forecast)
    @forecast = forecast
  end
end
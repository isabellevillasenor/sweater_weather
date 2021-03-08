class Api::V1::ForecastController < ApplicationController
  def show
    coords = MapQuestFacade.get_coords(params[:location])
    forecast = OpenWeatherFacade.get_weather(coords[:lat], coords[:lng])
    render json: ForecastSerializer.new(forecast)
  end
end
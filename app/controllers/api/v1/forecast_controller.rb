class Api::V1::ForecastController < ApplicationController
  def show
    if params[:location].present?
      coords = MapQuestFacade.get_coords(params[:location])
      forecast = OpenWeatherFacade.get_weather(coords[:lat], coords[:lng])
      render json: ForecastSerializer.new(forecast)
    else
      render json: { message: 'unsuccessful', error: 'Unable To Find Location/Forecast'}, status: 404
    end
  end
end
class Api::V1::ForecastController < ApplicationController
  def show
    coords = MapQuestFacade.get_coords(params[:location])
    # forecast = get_weather(coords[:lat], coords[:lng])
  end
end
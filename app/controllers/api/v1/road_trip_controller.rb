class Api::V1::RoadTripController < ApplicationController
  def create
    roadtrip_params = JSON.parse(request.body.string, symbolize_names: true)
    if roadtrip_params[:origin].empty? || roadtrip_params[:destination].empty?
      render json: {message: 'unsuccessful', error: 'Missing/Empty Fields'}, status: 400 
    elsif User.find_by(api_key: roadtrip_params[:api_key])
      road_trip = MapQuestFacade.road_trip(roadtrip_params)
      render json: RoadTripSerializer.new(road_trip) if road_trip.instance_of?(RoadTrip)
    else
      render json: {message: 'unsuccessful', error: 'Api Key Incorrect'}, status: 404
    end
  end
end
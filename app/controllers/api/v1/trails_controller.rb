class Api::V1::TrailsController < ApplicationController
  def show
    #get the travel time
    get_coords = MapQuestFacade.get_coords(params[:destination])
    lat = get_coords[:lat].to_s
    lng = get_coords[:lng].to_s
    coords = lat + ',' + lng
    travel_json = MapQuestFacade.travel_time(params[:start], coords)
    @time = Time.at(travel_json[:route][:formattedTime].to_time).to_i

    #get the trails in city with required steps
    nmcity = params[:destination].capitalize
    conn = Faraday.new("https://prescriptiontrails.org")
    response = conn.get("/api/filter/?by=city&city=#{nmcity}&offset=0&count=3&steps=1000")
    trails = JSON.parse(response.body, symbolize_names: true)

    trails[:trails][0..2].map do |trail|
      x = trail[:loops]
      if x[:'1'][:steps] > 1000
        weather = OpenWeatherService.get_weather(trail[:lat], trail[:lng])
        destination_weather = TrailForecast.new(weather, @time)
        new_trail = Trail.new(trail)
        new_trail.add_forecast(destination_weather)
        render json: TrailSerializer.new(new_trail)
      end
    end
  end
end
class Api::V1::TrailsController < ApplicationController
  def show
    binding.pry
    #get the trails in city with required steps
    nmcity = params[:destination].capitalize
    conn = Faraday.new("https://prescriptiontrails.org")
    response = conn.get("/api/filter/?by=city&city=#{nmcity}&offset=0&count=3&steps=1000")
    json1 = JSON.parse(response.body, symbolize_names: true)
    
    #get the travel time this should be in lat/lng for both sante fe and the destination = trail lat/lng
    conn = Faraday.new("https://open.mapquestapi.com")
    response = conn.get("/directions/v2/route?from=#{params[:start]}&key=#{ENV['MAPQUEST_API_KEY']}&to=#{json1[:trails][0][:lat]},#{json1[:trails][0][:lng]}")
    json2 = JSON.parse(response.body, symbolize_names: true)
    @time = Time.at(json2[:route][:formattedTime].to_time).to_i

    #get the weather based off time of arrival
    weather = OpenWeatherService.get_weather(json1[:trails][:lat], json1[:trails][:lng])
    #return Trail PORO
    destination_weather = TripForecast.new(weather, @time)
    trail.add_forecast(destination_weather)
    trail
    #render serializer

  end
end
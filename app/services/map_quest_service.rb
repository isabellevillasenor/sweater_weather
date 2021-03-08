class MapQuestService
  class << self
    def get_coords(location)
      conn = Faraday.new("http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAPQUEST_API_KEY']}&location=#{location}")
      response = conn.get
      JSON.parse(response.body, symbolize_names: true)
    end

    def travel_time(start, destination)
      conn = Faraday.new("http://open.mapquestapi.com/directions/v2/route?from=#{start}&key=#{ENV['MAPQUEST_API_KEY']}&to=#{destination}")
      response = conn.get
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
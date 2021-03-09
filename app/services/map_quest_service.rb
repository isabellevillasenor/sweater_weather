class MapQuestService
  class << self
    def get_coords(location)
      conn = Faraday.new("https://www.mapquestapi.com")
      response = conn.get("/geocoding/v1/address?key=#{ENV['MAPQUEST_API_KEY']}&location=#{location}")
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
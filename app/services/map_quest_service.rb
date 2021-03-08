class MapQuestService
  class << self
    def get_coords(location)
      conn = Faraday.new("http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAPQUEST_API_KEY']}&location=#{location}")
      response = conn.get
      JSON.parse(response.body, symbolize_names: true)
    end

  #   private

  #   def conn
  #     conn = Faraday.new('http://www.mapquestapi.com')
  #   end

  #   def to_json(url)
  #     response = conn.get(url)
  #     JSON.parse(response.body, symbolize_names: true)
  #   end
  end
end
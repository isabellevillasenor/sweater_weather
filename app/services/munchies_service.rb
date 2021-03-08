class MunchiesService
  class << self
    def get_munchies(lat, lng, food, time)
      conn = Faraday.new("http://api.yelp.com/v3/businesses/search?latitude=#{lat}&longitude=#{lng}&food=#{food}&open_at=#{time}")
      conn.authorization :Bearer, (ENV['YELP_API_KEY']).to_s
      conn.headers['Authorization']
      response = conn.get
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
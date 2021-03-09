class UnsplashService
  class << self
    def search(city)
      conn = Faraday.new("http://api.unsplash.com/search/photos?client_id=#{ENV['UNSPLASH_API_KEY']}&query=#{city}&page=1&per_page=1")
      response = conn.get
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
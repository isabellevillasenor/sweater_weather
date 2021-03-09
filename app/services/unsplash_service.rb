class UnsplashService
  class << self
    def search(city)
      conn = Faraday.new("https://api.unsplash.com")
      response = conn.get("/search/photos?") do |req|
        req.params[:client_id] = ENV['UNSPLASH_API_KEY']
        req.params[:query] = city
        req.params[:page] = 1
        req.params[:per_page] = 1
      end
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
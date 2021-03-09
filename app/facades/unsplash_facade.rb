class UnsplashFacade
  class << self
    def search(location)
      city = location.split(',')[0]
      response = UnsplashService.search(city)
      BackgroundImage.new(response[:results][0], location)
    end
  end
end
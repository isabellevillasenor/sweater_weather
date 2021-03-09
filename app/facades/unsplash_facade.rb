class UnsplashFacade
  class << self
    def search(location)
      response = UnsplashService.search(location)
      BackgroundImage.new(response[:results][0], location)
    end
  end
end
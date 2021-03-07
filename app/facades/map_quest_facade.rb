class MapQuestFacade
  class << self
    def get_coords(location)
      json = MapQuestService.get_coords(location)
      json[:results][0][:locations][0][:latLng]
    end
  end
end
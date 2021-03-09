class MapQuestFacade
  class << self
    def get_coords(location)
      json = MapQuestService.get_coords(location)
      json[:results][0][:locations][0][:latLng]
    end

    def travel_time(start, destination)
      json = MapQuestService.travel_time(start, destination)
      # @time = Time.at(json[:route][:formattedTime].to_time).to_i
      #iterate throught the 3 responses and turn them into Trail PORO

    end
  end
end
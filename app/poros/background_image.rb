class BackgroundImage
  attr_reader :image
  def initialize(data, location)
    @image = {
              location: location,
              image_url: data[:urls][:full],
              credit: {
                source: 'https://unsplash.com/',
                author: data[:user][:name],
                logo: data[:user][:links][:html]
              }
            }
  end
end
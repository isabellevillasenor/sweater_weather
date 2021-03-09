class BackgroundImage
  attr_reader :id,
              :location,
              :image_url,
              :credit
  def initialize(data, location)
    @id = nil
    @location = location
    @image_url = data[:urls][:full]
    @credit = create_credit(data)
  end

  def create_credit(data)
    {
      source: 'https://unsplash.com/',
      author: data[:user][:name],
      author_username: data[:user][:username],
      logo: data[:user][:links][:html]
    }
  end
end
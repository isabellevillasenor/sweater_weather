class Api::V1::ImagesController < ApplicationController
  def show
    image = UnsplashFacade.search(params[:location])
    render json: ImageSerializer.new(image)
  end
end
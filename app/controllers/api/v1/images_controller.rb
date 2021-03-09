class Api::V1::ImagesController < ApplicationController
  def show
    if params[:location].present?
      image = UnsplashFacade.search(params[:location])
      render json: ImageSerializer.new(image)
    else
      render json: { message: 'unsuccessful', error: 'Unable To Find Image/Location'}, status: 404
    end
  end
end
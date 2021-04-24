class Api::V1::ImagesController < ApplicationController
  def skyline_image
    if params[:location].empty?
      render json: ({ error: 'A valid location parameter is required' })
    else
      render json: ImageFacade.skyline(params[:location])
    end
  end
end

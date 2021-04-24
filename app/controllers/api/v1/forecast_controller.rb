class Api::V1::ForecastController < ApplicationController
  def local_five_day
    if params[:location].empty?
      render json: ({ error: 'A valid location parameter is required' })
    else
      render json: ForecastFacade.local_five_day(params[:location])
    end
  end
end

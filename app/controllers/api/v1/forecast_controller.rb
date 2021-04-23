class Api::V1::ForecastController < ApplicationController
  def local_five_day
    loc = params[:location]
    require "pry"; binding.pry
    get_coords(loc)
  end

  def coordinate_connection
    coordinate_connection ||= Faraday.new({
      url: ENV['COORD_URL'],
      key: ENV['COORD_KEY']
    })
  end

  def get_coords(loc)
    coordinate_connection.get("/geocoding/v1/address?location=#{loc}")
  end

  # def weather_connection
    # weather_connection ||= Faraday.new({
      # url:
    # })
  # end

end

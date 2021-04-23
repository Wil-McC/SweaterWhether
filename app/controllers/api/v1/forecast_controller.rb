class Api::V1::ForecastController < ApplicationController
  def local_five_day
    loc = params[:location]
    lat_lng = get_coords(loc)
  end

  def coordinate_connection
    coordinate_connection ||= Faraday.new({
      url: ENV['COORD_URL']
    })
  end

  def get_coords(loc)
    res = coordinate_connection.get("/geocoding/v1/address?key=#{ENV['COORD_KEY']}&location=#{loc}")
    data = JSON.parse(res.body, symbolize_names: true)
    lat_lng_hash = data[:results][0][:locations][0][:latLng]
  end

  # def weather_connection
    # weather_connection ||= Faraday.new({
      # url:
    # })
  # end

end

class Api::V1::ForecastController < ApplicationController
  def local_five_day
    loc = params[:location]
    lat_lng = get_coords(loc)
    raw_weather = get_five_day(lat_lng[:lat], lat_lng[:lng])
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

  def weather_connection
    weather_connection ||= Faraday.new({
      url:
    })
  end

  def get_five_day(lat, lon)
    res = weather_connection.get("/data/2.5/onecall?lat=#{lat}&lon=#{lon}&exclude={minutely,alerts}&appid=#{ENV['WEATHER_KEY']}")
  end

end

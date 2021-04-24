require 'date'

class Api::V1::ForecastController < ApplicationController
  def local_five_day
    loc = params[:location]
    lat_lng = get_coords(loc)
    forecast = get_five_day(lat_lng[:lat], lat_lng[:lng])
    payload = ForecastSerializer.new(forecast)
    require "pry"; binding.pry
  end

  def coordinate_connection
    coordinate_connection ||= Faraday.new({
      url: ENV['COORD_URL']
    })
  end

  def get_coords(loc)
    res = coordinate_connection.get("/geocoding/v1/address?key=#{ENV['COORD_KEY']}&location=#{loc}")
    data = JSON.parse(res.body, symbolize_names: true)

    data[:results][0][:locations][0][:latLng]
  end

  def weather_connection
    weather_connection ||= Faraday.new({
      url: ENV['WEATHER_URL']
    })
  end

  def get_five_day(lat, lon)
    res = weather_connection.get("/data/2.5/onecall?lat=#{lat}&lon=#{lon}&units=imperial&exclude=minutely,alerts&appid=#{ENV['WEATHER_KEY']}")
    data = JSON.parse(res.body, symbolize_names: true)

    forecast_builder(data)
  end

  def forecast_builder(data)
    ForecastFull.new(data)
  end

end

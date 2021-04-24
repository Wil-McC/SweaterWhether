require 'date'

class Api::V1::ForecastController < ApplicationController
  def local_five_day
    loc = params[:location]
    lat_lng = get_coords(loc)
    # return error message if API defaults on location
    if lat_lng[:lat] == 39.390897 && lat_lng[:lng] == -99.066067
      render json: ({ error: 'Please provide a valid location' })
    else
      forecast = get_five_day(lat_lng[:lat], lat_lng[:lng])
      render json: ForecastFullSerializer.new(forecast)
    end
  end

  def coordinate_connection
    coordinate_connection ||= Faraday.new({
      url: ENV['COORD_URL']
    })
  end

  def get_coords(loc)
    res = coordinate_connection.get("/geocoding/v1/address") do |req|
      req.params['key'] = ENV['COORD_KEY']
      req.params['location'] = loc
    end
    data = JSON.parse(res.body, symbolize_names: true)
    # pull lat and long hash out of payload
    data[:results][0][:locations][0][:latLng]
  end

  def weather_connection
    weather_connection ||= Faraday.new({
      url: ENV['WEATHER_URL']
    })
  end

  def get_five_day(lat, lon)
    res = weather_connection.get("/data/2.5/onecall") do |req|
      req.params['lat'] = lat
      req.params['lon'] = lon
      req.params['units'] = 'imperial'
      req.params['exclude'] = 'minutely,alerts'
      req.params['appid'] = ENV['WEATHER_KEY']
    end
    data = JSON.parse(res.body, symbolize_names: true)

    forecast_builder(data)
  end

  def forecast_builder(data)
    ForecastFull.new(data)
  end
end

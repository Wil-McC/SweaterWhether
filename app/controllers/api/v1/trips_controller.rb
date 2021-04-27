class Api::V1::TripsController < ApplicationController
  def arrival
    user = User.find_by(api_key: trip_info[:api_key])

    if user != nil
      orig = string_cleaner(trip_info[:origin])
      dest = string_cleaner(trip_info[:destination])

      hours = travel_time(orig, dest)
      if hours == 'impossible'
        forecast = {}
        length   = hours
      else
        forecast = future_weather(hours)
        length   = hours[:hrs]
      end

      output = trip_struct(trip_info[:origin], trip_info[:destination], length, forecast)
      
      render json: RoadtripSerializer.new(output)
    else
      render json: ({ error: 'Invalid key provided' }), status: 401
    end
  end

  def trip_struct(orig, dest, length, forecast)
    OpenStruct.new(
      id: nil,
      start_city: orig,
      end_city: dest,
      travel_time: length,
      weather_at_eta: forecast
    )
  end

  def travel_time(orig, dest)
    GeoService.travel_time(orig, dest)
  end

  def future_weather(hours)
    ForecastFacade.eta_weather(hours)
  end

  def string_cleaner(str)
    str.gsub(/,/,"")
  end

  private

  def trip_info
    JSON.parse(request.body.read, symbolize_names: true)
  end
end

class Api::V1::TripsController < ApplicationController
  def arrival
    user = User.find_by(api_key: trip_info[:api_key])

    if user != nil
      orig = string_cleaner(trip_info[:origin])
      dest = string_cleaner(trip_info[:destination])

      hours = travel_time(orig, dest)
      # forecast = future_weather(dest, hours)
      # a = ArrivalCast.new(hours, forecast)
      # render json: ArrivalCastSerializer.new(a)
    else
      render json: ({ error: 'Invalid key provided' }), status: 401
    end
  end

  def travel_time(orig, dest)
    GeoService.travel_time(orig, dest)
  end

  def string_cleaner(str)
    str.gsub(/,/,"")
  end

  private

  def trip_info
    JSON.parse(request.body.read, symbolize_names: true)
  end
end

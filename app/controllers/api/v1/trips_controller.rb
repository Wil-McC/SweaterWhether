class Api::V1::TripsController < ApplicationController
  def arrival
    user = User.find_by(api_key: trip_info[:api_key])

    if user != nil
      origin = trip_info[:origin]
      destination = trip_info[:destination]

      output = TripFacade.weather_eta(origin, destination)
      render json: RoadtripSerializer.new(output)
    else
      render json: ({ error: 'Invalid key provided' }), status: 401
    end
  end

  private

  def trip_info
    JSON.parse(request.body.read, symbolize_names: true)
  end
end

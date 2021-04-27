class Api::V1::TripsController < ApplicationController
  def arrival
    user = User.find_by(api_key: trip_info[:api_key])

    if user != nil && !trip_info[:origin].empty? && !trip_info[:destination].empty?
      origin = trip_info[:origin]
      destination = trip_info[:destination]

      output = TripFacade.weather_eta(origin, destination)
      render json: RoadtripSerializer.new(output)
    elsif trip_info[:origin].empty? || trip_info[:destination].empty?
      render json: ({ error: 'Origin and destination city must be provided' }), status: 400
    elsif user == nil
      render json: ({ error: 'Invalid key provided' }), status: 401
    else
      render json: ({ error: 'Something went wrong' }), status: 400
    end
  end

  private

  def trip_info
    JSON.parse(request.body.read, symbolize_names: true)
  end
end

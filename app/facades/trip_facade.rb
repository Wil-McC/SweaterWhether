class TripFacade
  def self.weather_eta(origin, destination)
    orig = string_cleaner(origin)
    dest = string_cleaner(destination)

    hours = travel_time(orig, dest)
    if hours == 'impossible'
      forecast = {}
      length   = hours
    else
      forecast = eta_weather(hours)
      length   = hours[:hrs]
    end

    trip_struct(origin, destination, length, forecast)
  end

  def self.travel_time(orig, dest)
    GeoService.travel_time(orig, dest)
  end

  def self.eta_weather(hours_hash)
    lat = hours_hash[:lat]
    lon = hours_hash[:lng]
    round_hour= hours_hash[:hrs_raw].floor

    forecast = ForecastService.forty_eight(lat, lon)
    forecast[round_hour]
  end

  def self.trip_struct(orig, dest, length, forecast)
    OpenStruct.new(
      id: nil,
      start_city: orig,
      end_city: dest,
      travel_time: length,
      weather_at_eta: forecast
    )
  end

  def self.string_cleaner(str)
    str.gsub(/,/,"")
  end
end

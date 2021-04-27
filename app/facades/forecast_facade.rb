class ForecastFacade
  def self.local_five_day(loc)
    lat_lng = GeoService.get_coords(loc)
    # return error message if API defaults on location
    if lat_lng[:lat] == 39.390897 && lat_lng[:lng] == -99.066067
      ({ error: 'Please provide a valid location' })
    else
      forecast = ForecastService.get_five_day(lat_lng[:lat], lat_lng[:lng])
      ForecastFullSerializer.new(forecast)
    end
  end
end

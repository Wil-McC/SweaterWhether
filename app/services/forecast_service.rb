class ForecastService
  def self.get_five_day(lat, lon)
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

  def self.weather_connection
    weather_connection ||= Faraday.new({
      url: ENV['WEATHER_URL']
    })
  end

  def self.forecast_builder(data)
    ForecastFull.new(data)
  end
end

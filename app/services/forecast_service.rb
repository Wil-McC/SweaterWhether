class ForecastService
  def self.get_five_day(lat, lon)
    data = weather_data(lat, lon)

    forecast_builder(data)
  end

  def self.forty_eight(lat, lon)
    data = weather_data(lat, lon)

    hourly_array(data)
  end

  def self.weather_data(lat, lon)
    res = weather_connection.get("/data/2.5/onecall") do |req|
      req.params['lat'] = lat
      req.params['lon'] = lon
      req.params['units'] = 'imperial'
      req.params['exclude'] = 'minutely,alerts'
      req.params['appid'] = ENV['WEATHER_KEY']
    end
    JSON.parse(res.body, symbolize_names: true)
  end

  def self.weather_connection
    weather_connection ||= Faraday.new({
      url: ENV['WEATHER_URL']
    })
  end

  def self.forecast_builder(data)
    ForecastFull.new(data)
  end

  def self.hourly_array(data)
    data[:hourly].map do |hour|
      {
        temperature: hour[:temp],
        conditions:  hour[:weather][0][:description]
      }
    end
  end
end

class ForecastFull
  attr_reader :id,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(data)
    @id              = nil
    @current_weather = current_cleaner(data)
    @daily_weather   = daily_cleaner(data)
    @hourly_weather  = hourly_cleaner(data)
  end

  def current_cleaner(data)
    {
      datetime:    Time.at(data[:current][:dt]).to_datetime,
      sunrise:     Time.at(data[:current][:sunrise]).to_datetime,
      sunset:      Time.at(data[:current][:sunset]).to_datetime,
      temperature: data[:current][:temp],
      feels_like:  data[:current][:feels_like],
      humidity:    data[:current][:humidity],
      uvi:         data[:current][:uvi],
      visibility:  data[:current][:visibility],
      conditions:  data[:current][:weather][0][:description],
      icon:        data[:current][:weather][0][:icon]
    }
  end

  def daily_cleaner(data)
    data[:daily].first(5).map do |day|
      {
        date:       Time.at(day[:dt]).to_date,
        sunrise:    Time.at(day[:sunrise]).to_datetime,
        sunset:     Time.at(day[:sunset]).to_datetime,
        max_temp:   day[:temp][:max],
        min_temp:   day[:temp][:min],
        conditions: day[:weather][0][:description],
        icon:       day[:weather][0][:icon]
      }
    end
  end

  def hourly_cleaner(data)
    data[:hourly].first(8).map do |hour|
      {
        time:        Time.at(hour[:dt]).strftime('%T'),
        temperature: hour[:temp],
        conditions:  hour[:weather][0][:description],
        icon:        hour[:weather][0][:icon]
      }
    end
  end
end

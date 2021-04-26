class SalaryFacade
  def self.salary_forecast(des)
    lat_lng = GeoService.get_coords(des)
    extended = ForecastService.get_five_day(lat_lng[:lat], lat_lng[:lng])
    forecast = slim_weather(extended.current_weather)

    salaries = SalaryService.fetch_salaries(des)
    sf_builder(des, forecast, salaries)
  end

  def self.slim_weather(hash)
    {
      summary: hash[:conditions],
      temperature: "#{hash[:temperature]} F"
    }
  end

  def self.sf_builder(des, forecast, salaries)
    OpenStruct.new(
      id: nil,
      destination: des,
      forecast: forecast,
      salaries: salaries
    )
  end
end

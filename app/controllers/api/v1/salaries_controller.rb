class Api::V1::SalariesController < ApplicationController
  def salary_forecast
    des = params[:destination]

    # lat_lng = GeoService.get_coords(des)
    # extended = ForecastService.get_five_day(lat_lng[:lat], lat_lng[:lng])
    # forecast = extended.current_weather

    salary_data = fetch_salaries(des)
  end


  def fetch_salaries(des)
    res = ua_connection.get("/api/urban_areas/slug:#{des}/salaries")

    data = JSON.parse(res.body, symbolize_names: true)
  end

  def self.ua_connection
    ua_connection ||= Faraday.new({
      url: 'https://api.teleport.org'
    })
  end
end

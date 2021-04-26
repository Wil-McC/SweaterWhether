class Api::V1::SalariesController < ApplicationController
  def salary_forecast
    des = params[:destination]

    salary_data = SalaryFacade.salary_forecast(des)
    # facade \/
    # lat_lng = GeoService.get_coords(des)
    # extended = ForecastService.get_five_day(lat_lng[:lat], lat_lng[:lng])
    # forecast = slim_weather(extended.current_weather)

    # salaries = fetch_salaries(des)
    # sf = forecast_builder(des, forecast, salaries)
    # SalaryForecastSerializer.new(sf)

    render json: SalaryForecastSerializer.new(salary_data)
  end

  # def forecast_builder(des, forecast, salaries)
  #   OpenStruct.new(
  #     id: nil,
  #     destination: des,
  #     forecast: forecast,
  #     salaries: salaries
  #   )
  # end

  # def slim_weather(hash)
  #   {
  #     summary: hash[:conditions],
  #     temperature: "#{hash[:temperature]} F"
  #   }
  # end

  # def fetch_salaries(des)
  #   res = ua_connection.get("/api/urban_areas/slug:#{des}/salaries")
  #
  #   data = JSON.parse(res.body, symbolize_names: true)
  #
  #   target_roles(data[:salaries])
  # end

  # def target_roles(jobs)
  #   list = ['Data Analyst', 'Data Scientist', 'Mobile Developer', 'QA Engineer', 'Software Engineer', 'Systems Administrator', 'Web Developer' ]
  #   # refactor to not repeat iteration - if list.includes?(job[:job][:title])
  #   list.flat_map do |role|
  #     jobs.each_with_object({}) do |job, acc|
  #       if job[:job][:title] == role
  #         acc[:title] = job[:job][:title]
  #         acc[:min]   = job[:salary_percentiles][:percentile_25].round(2)
  #         acc[:max]   = job[:salary_percentiles][:percentile_75].round(2)
  #       end
  #     end
  #   end
  # end

  # def ua_connection
  #   ua_connection ||= Faraday.new({
  #     url: 'https://api.teleport.org'
  #   })
  # end
end

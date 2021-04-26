class Api::V1::SalariesController < ApplicationController
  def salary_forecast
    des = params[:destination]

    salary_data = SalaryFacade.salary_forecast(des)

    render json: SalaryForecastSerializer.new(salary_data)
  end
end

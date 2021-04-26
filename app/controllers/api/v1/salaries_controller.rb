class Api::V1::SalariesController < ApplicationController
  def salary_forecast
    des = params[:destination]

    salary_struct = SalaryFacade.salary_forecast(des)

    render json: SalaryForecastSerializer.new(salary_struct)
  end
end

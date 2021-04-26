class SalaryForecastSerializer
  include FastJsonapi::ObjectSerializer

  set_type :salaries
  attributes :destination, :forecast, :salaries
end

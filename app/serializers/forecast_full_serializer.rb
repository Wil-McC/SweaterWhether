class ForecastFullSerializer
  include FastJsonapi::ObjectSerializer

  set_type :forecast
  attributes :current_weather, :daily_weather, :hourly_weather
end

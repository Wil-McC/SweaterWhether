require 'rails_helper'

RSpec.describe 'the forecast service' do
  it "returns weather data payload as PORO" do
    VCR.use_cassette('forecast_service') do
      res = ForecastService.get_five_day(39.749672, -105.216019)
      
      expect(res).to be_a(ForecastFull)
      expect(res.respond_to?('current_weather')).to eq(true)
      expect(res.respond_to?('daily_weather')).to eq(true)
      expect(res.daily_weather).to be_an(Array)
      expect(res.daily_weather.length).to eq(5)
      expect(res.respond_to?('hourly_weather')).to eq(true)
      expect(res.hourly_weather).to be_a(Array)
      expect(res.hourly_weather.length).to eq(8)
      expect(res.respond_to?('id')).to eq(true)
      expect(res.id).to eq(nil)
    end
  end
end

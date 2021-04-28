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
  it "forty_eight returns an array with 48 hours of temp and condition hashes" do
    VCR.use_cassette('forety_eight') do
      arr = ForecastService.forty_eight(39.749672, -105.216019)

      expect(arr).to be_an(Array)
      expect(arr.length).to eq(48)
      expect(
        arr.all? do |hour|
          hour.keys                == [:temperature, :conditions]
          hour[:temperature].class == Float
          hour[:conditions].class  == String
        end
      )
    end
  end
end

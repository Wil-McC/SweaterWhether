require 'rails_helper'

RSpec.describe 'the forecast request' do
  describe 'happy path' do
    it 'returns payload with correct structure' do
      VCR.use_cassette('full_forecast') do
        get '/api/v1/forecast?location=denver,co'
        expect(response).to be_successful
        forecast = JSON.parse(response.body, symbolize_names: true)

        expect(forecast).to be_a(Hash)
        expect(forecast.keys).to eq([:data])
        expect(forecast[:data].keys).to eq([:id, :type, :attributes])
        expect(forecast[:data][:id]).to eq(nil)
        expect(forecast[:data][:attributes].keys).to eq([:current_weather, :daily_weather, :hourly_weather])
        # current_weather data tests
        cw = forecast[:data][:attributes][:current_weather]
        expect(cw.keys).to eq([:datetime, :sunrise, :sunset, :temperature, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon])
        expect(cw[:datetime]).to eq("2021-04-24T12:55:29.000-06:00")
        expect(cw[:datetime]).to be_a(String)
        expect(cw[:sunrise]).to eq("2021-04-24T06:08:57.000-06:00")
        expect(cw[:sunrise]).to be_a(String)
        expect(cw[:sunset]).to eq("2021-04-24T19:46:43.000-06:00")
        expect(cw[:sunset]).to be_a(String)
        expect(cw[:temperature]).to eq(58.33)
        expect(cw[:temperature]).to be_a(Float)
        expect(cw[:feels_like]).to eq(56.17)
        expect(cw[:feels_like]).to be_a(Float)
        expect(cw[:humidity]).to eq(49)
        expect(cw[:humidity]).to be_an(Integer)
        expect(cw[:uvi]).to eq(6.35)
        expect(cw[:uvi]).to be_a(Float)
        expect(cw[:visibility]).to eq(10000)
        expect(cw[:visibility]).to be_an(Integer)
        expect(cw[:conditions]).to eq('overcast clouds')
        expect(cw[:conditions]).to be_a(String)
        expect(cw[:icon]).to eq("04d")
        expect(cw[:icon]).to be_a(String)
        # daily_weather data tests
        dw = forecast[:data][:attributes][:daily_weather]
        expect(
          dw.all? do |day|
            day.class == Hash
          end
        ).to eq(true)
        expect(
          dw.all? do |day|
            day.keys == [:date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon]
          end
        ).to eq(true)
        expect(
          dw.all? do |day|
            day[:date].class == String
            day[:sunrise].class == String
            day[:sunset].class == String
            day[:max_temp].class == Float
            day[:min_temp].class == Float
            day[:conditions].class == String
            day[:icon].class == String
          end
        ).to eq(true)
        # hourly_weather data tests
        hw = forecast[:data][:attributes][:hourly_weather]
        expect(
          hw.all? do |h|
            h.class == Hash
            h.keys == [:time, :temperature, :conditions, :icon]
            h[:time].class == String
            h[:temperature].class == Float
            h[:conditions].class == String
            h[:icon].class == String
          end
        ).to eq(true)
      end
    end
  end
  describe 'sad path' do
    it 'returns error message when bad location' do
      VCR.use_cassette('bad_location') do
        get '/api/v1/forecast?location=zorgbleep'
        expect(response).to be_successful
        forecast = JSON.parse(response.body, symbolize_names: true)

        expect(forecast).to be_a(Hash)
        expect(forecast.keys).to eq([:error])
        expect(forecast[:error]).to eq("Please provide a valid location")
      end
    end
    it "returns error message when no location" do
      VCR.use_cassette('no_location') do
        get '/api/v1/forecast?location='
        expect(response).to be_successful
        forecast = JSON.parse(response.body, symbolize_names: true)

        expect(forecast).to be_a(Hash)
        expect(forecast.keys).to eq([:error])
        expect(forecast[:error]).to eq("A valid location parameter is required")
      end
    end
  end
end

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
        expect(forecast[:data][:attributes][:current_weather].keys).to eq([:datetime, :sunrise, :sunset, :temperature, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon])
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

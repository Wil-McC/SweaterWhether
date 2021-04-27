require 'rails_helper'

RSpec.describe 'the trip facade' do
  it 'weather eta returns trip info ostruct' do
    VCR.use_cassette('road_trip_happy') do
      res = TripFacade.weather_eta('denver,co', 'sarasota, fl')

      expect(res).to be_an(OpenStruct)
      expect(res.respond_to?('id')).to eq(true)
      expect(res.id).to eq(nil)
      expect(res.respond_to?('start_city')).to eq(true)
      expect(res.start_city).to eq('denver,co')
      expect(res.respond_to?('end_city')).to eq(true)
      expect(res.end_city).to eq('sarasota, fl')
      expect(res.respond_to?('travel_time')).to eq(true)
      expect(res.travel_time).to eq("28 hours, 6 minutes")
      expect(res.respond_to?('weather_at_eta'))
      expect(res.weather_at_eta).to be_a(Hash)
      expect(res.weather_at_eta.keys).to eq([:temperature, :conditions])
      expect(res.weather_at_eta[:temperature]).to eq(77.86)
      expect(res.weather_at_eta[:conditions]).to eq("few clouds")
    end
  end
  it "travel_time" do
    VCR.use_cassette('travel_time_test') do
      res = TripFacade.travel_time('denver,co', 'sarasota, fl')

      expect(res).to be_a(Hash)
      expect(res.keys).to eq([:lng, :lat, :hrs_raw, :hrs])
      expect(res[:lng]).to eq(-82.538602)
      expect(res[:lat]).to eq(27.336483)
      expect(res[:hrs_raw]).to eq(28.11277777777778)
      expect(res[:hrs]).to eq("28 hours, 6 minutes")
    end
  end
  it "trip_struct creates object" do
    orig = 'denver, co'
    dest = 'sarasota, fl'
    length = '28 hours, 6 minutes'
    forecast = { temperature: 77.86, conditions: "few clouds" }

    o = TripFacade.trip_struct(orig, dest, length, forecast)

    expect(o).to be_an(OpenStruct)
    expect(o.respond_to?('id')).to eq(true)
    expect(o.id).to eq(nil)
    expect(o.respond_to?('start_city')).to eq(true)
    expect(o.start_city).to eq('denver, co')
    expect(o.respond_to?('end_city')).to eq(true)
    expect(o.end_city).to eq('sarasota, fl')
    expect(o.respond_to?('travel_time')).to eq(true)
    expect(o.travel_time).to eq("28 hours, 6 minutes")
    expect(o.respond_to?('weather_at_eta'))
    expect(o.weather_at_eta).to be_a(Hash)
    expect(o.weather_at_eta.keys).to eq([:temperature, :conditions])
    expect(o.weather_at_eta[:temperature]).to eq(77.86)
    expect(o.weather_at_eta[:conditions]).to eq("few clouds")
  end
end

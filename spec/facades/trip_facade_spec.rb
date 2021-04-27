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
end

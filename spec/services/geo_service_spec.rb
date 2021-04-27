require 'rails_helper'

RSpec.describe 'the geo service' do
  describe 'happy path' do
    it 'returns payload with lat and long coordinates' do
      VCR.use_cassette('happy_geo') do
        res = GeoService.get_coords('golden,co')
        expect(res).to be_a(Hash)
        expect(res.keys).to eq([:lat, :lng])
        expect(res[:lat]).to eq(39.749672)
        expect(res[:lng]).to eq(-105.216019)
      end
    end
    describe 'travel time methods' do
      it 'returns hours if route is valid' do
        VCR.use_cassette('travel_time_happy') do
          res = GeoService.travel_time('denver co', 'lander wy')

          expect(res).to be_a(Hash)
          expect(res.keys).to eq([:lng, :lat, :hrs_raw, :hrs])
          expect(res[:lng]).to be_a(Float)
          expect(res[:lat]).to be_a(Float)
          expect(res[:hrs_raw]).to be_a(Float)
          expect(res[:hrs]).to be_a(String)
        end
      end
      it "human time returns string of hours and minutes" do
        res = GeoService.human_time(5.41001123)

        expect(res).to be_a(String)
        expect(res).to eq('5 hours, 24 minutes')
      end
    end
  end
  describe 'sad path' do
    it 'returns default coords on bad location' do
      VCR.use_cassette('sad_geo') do
        res = GeoService.get_coords('morgulax')
        expect(res).to be_a(Hash)
        expect(res.keys).to eq([:lat, :lng])
        expect(res[:lat]).to eq(39.390897)
        expect(res[:lng]).to eq(-99.066067)
      end
    end
    describe 'travel time method' do
      it 'returns impossible if route is valid' do
        VCR.use_cassette('travel_time_sad') do
          res = GeoService.travel_time('denver co', 'honolulu hi')

          expect(res).to be_a(String)
          expect(res).to eq('impossible')
        end
      end
    end
  end
end

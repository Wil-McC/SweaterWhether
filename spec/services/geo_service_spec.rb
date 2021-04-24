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
  end
end

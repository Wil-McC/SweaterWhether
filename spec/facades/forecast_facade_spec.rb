require 'rails_helper'

RSpec.describe 'the forecast facade' do
  describe 'happy path' do
    it 'returns serialized weather forecast data' do
      VCR.use_cassette('golden_five_day') do
        out = ForecastFacade.local_five_day('golden,co')

        expect(out.class).to eq(ForecastFullSerializer)
      end
    end
  end
  describe 'sad path' do
    it 'returns error hash if location is bad' do
      VCR.use_cassette('forecast_facade_sad') do
        out = ForecastFacade.local_five_day('globular')

        expect(out).to be_a(Hash)
        expect(out.keys).to eq([:error])
        expect(out[:error]).to eq('Please provide a valid location')
      end
    end
  end
end

require 'rails_helper'

RSpec.describe 'the background request' do
  describe 'happy path' do
    it 'returns a single image JSON payload with credits' do
      VCR.use_cassette('image_search_happy') do
        get '/api/v1/backgrounds?location=denver,co'
        expect(response).to be_successful
        result = JSON.parse(response.body, symbolize_names: true)

        # TODO - test structure of payload and data values
      end
    end
  end
end

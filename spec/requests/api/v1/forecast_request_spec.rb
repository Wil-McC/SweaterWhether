require 'rails_helper'

RSpec.describe 'the forecast request' do
  describe 'happy path' do
    it 'returns payload with correct structure' do
      get '/api/v1/forecast?location=denver,co'
      expect(response).to be_successful
      merchants = JSON.parse(response.body, symbolize_names: true)
    end
  end
end

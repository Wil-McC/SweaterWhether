require 'rails_helper'

RSpec.describe 'the background request' do
  describe 'happy path' do
    it 'returns a single image JSON payload with credits' do
      VCR.use_cassette('image_search_happy') do
        get '/api/v1/backgrounds?location=denver,co'
        expect(response).to be_successful
        result = JSON.parse(response.body, symbolize_names: true)

        expect(result).to be_a(Hash)
        expect(result.keys).to eq([:data])
        expect(result[:data].keys).to eq([:id, :type, :attributes])
        expect(result[:data][:id]).to eq(nil)
        expect(result[:data][:type]).to eq("image")
        expect(result[:data][:type]).to be_a(String)
        expect(result[:data][:attributes]).to be_a(Hash)
        expect(result[:data][:attributes].keys).to eq([:url, :photographer, :photographer_url, :src, :credit])
        expect(result[:data][:attributes][:url]).to be_a(String)
        expect(result[:data][:attributes][:photographer]).to be_a(String)
        expect(result[:data][:attributes][:photographer_url]).to be_a(String)
        expect(result[:data][:attributes][:src]).to be_a(String)
        expect(result[:data][:attributes][:credit]).to be_a(String)
      end
    end
  end
  describe 'sad path' do
    it 'returns error message' do
      VCR.use_cassette('image_search_sad') do
        get '/api/v1/backgrounds?location='
        expect(response).to be_successful
        result = JSON.parse(response.body, symbolize_names: true)

        expect(result).to be_a(Hash)
        expect(result.keys).to eq([:error])
        expect(result[:error]).to eq("A valid location parameter is required")
      end
    end
  end
end

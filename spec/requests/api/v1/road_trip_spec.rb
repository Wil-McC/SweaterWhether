require 'rails_helper'

RSpec.describe 'the road trip request' do
  describe 'happy path' do
    # create valid user
    before :each do
      uri = api_v1_users_path
      body = {
              "email": "meep@beep.com",
              "password": "zoomer",
              "password_confirmation": "zoomer"
              }
      headers = {'CONTENT_TYPE': 'application/json'}

      post uri, headers: headers, params: body, as: :json
    end
    it 'returns payload with correct structure and data' do
      VCR.use_cassette('road_trip_happy') do
        user = User.find_by(email: "meep@beep.com")
        k = user.api_key
        uri = api_v1_road_trip_path
        body = {
                "origin": "denver, co",
                "destination": "sarasota, fl",
                "api_key": "#{k}"
                }
        headers = {'CONTENT_TYPE': 'application/json'}
        post uri, headers: headers, params: body, as: :json

        expect(response).to be_successful
        expect(response.status).to eq(200)

        res = JSON.parse(response.body, symbolize_names: true)

        expect(res).to be_a(Hash)
        expect(res.keys).to eq([:data])
        expect(res[:data].keys).to eq([:id, :type, :attributes])
        expect(res[:data][:id]).to eq(nil)
        expect(res[:data][:type]).to be_a(String)
        expect(res[:data][:type]).to eq('roadtrip')
        expect(res[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
      end
    end
  end
  describe 'sad path' do
    before :each do
      uri = api_v1_users_path
      body = {
              "email": "meep@beep.com",
              "password": "zoomer",
              "password_confirmation": "zoomer"
              }
      headers = {'CONTENT_TYPE': 'application/json'}

      post uri, headers: headers, params: body, as: :json
    end
    it 'returns error when key is invalid' do
      uri = api_v1_road_trip_path
      body = {
              "origin": "denver, co",
              "destination": "sarasota, fl",
              "api_key": "beepbeepbeep"
              }
      headers = {'CONTENT_TYPE': 'application/json'}
      post uri, headers: headers, params: body, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      res = JSON.parse(response.body, symbolize_names: true)

      expect(res).to be_a(Hash)
      expect(res.keys).to eq([:error])
    end
    it 'returns payload with empty weather if route invalid' do
      VCR.use_cassette('road_trip_sad') do
        user = User.find_by(email: "meep@beep.com")
        k = user.api_key
        uri = api_v1_road_trip_path
        body = {
                "origin": "denver, co",
                "destination": "honolulu, hi",
                "api_key": "#{k}"
                }
        headers = {'CONTENT_TYPE': 'application/json'}
        post uri, headers: headers, params: body, as: :json

        expect(response).to be_successful
        expect(response.status).to eq(200)

        res = JSON.parse(response.body, symbolize_names: true)

        expect(res).to be_a(Hash)
        expect(res.keys).to eq([:data])
        expect(res[:data].keys).to eq([:id, :type, :attributes])
        expect(res[:data][:id]).to eq(nil)
        expect(res[:data][:type]).to be_a(String)
        expect(res[:data][:type]).to eq('roadtrip')
        expect(res[:data][:attributes][:start_city]).to eq('denver, co')
        expect(res[:data][:attributes][:end_city]).to eq('honolulu, hi')
        expect(res[:data][:attributes][:travel_time]).to eq("impossible")
        expect(res[:data][:attributes][:weather_at_eta]).to eq({})
      end
    end
    it "returns an error message if one or both trip points are empty" do
      user = User.find_by(email: "meep@beep.com")
      k = user.api_key
      uri = api_v1_road_trip_path
      body = {
              "origin": "",
              "destination": "",
              "api_key": "#{k}"
              }
      headers = {'CONTENT_TYPE': 'application/json'}
      post uri, headers: headers, params: body, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      res = JSON.parse(response.body, symbolize_names: true)
    end
  end
end

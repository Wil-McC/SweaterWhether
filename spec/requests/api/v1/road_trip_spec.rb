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
      end
    end
  end
  describe 'sad path' do
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
  end
end

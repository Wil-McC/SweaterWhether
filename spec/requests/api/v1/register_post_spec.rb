require 'rails_helper'

RSpec.describe 'the registration post request' do
  describe 'happy path' do
    it 'creates user, generates API key, and returns with 201' do
      uri = api_v1_users_path
      body = {
              "email": "meep@beep.com",
              "password": "zoomer",
              "password_confirmation": "zoomer"
              }
      headers = {'CONTENT_TYPE': 'application/json'}

      post uri, headers: headers, params: body, as: :json

      expect(response).to be_successful
      expect(response.status).to eq(201)
      res = JSON.parse(response.body, symbolize_names: true)

      expect(res.keys).to eq([:data])
      expect(res[:data].keys).to eq([:id, :type, :attributes])
      expect(res[:data][:attributes].keys).to eq([:email, :api_key])
    end
  end
end

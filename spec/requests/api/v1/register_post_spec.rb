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
    it 'password and confirmation do not match - conf' do
      uri = api_v1_users_path
      body = {
              "email": "amp@beep.com",
              "password": "zoomer",
              "password_confirmation": "zoom"
              }
      headers = {'CONTENT_TYPE': 'application/json'}

      post uri, headers: headers, params: body, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      res = JSON.parse(response.body, symbolize_names: true)

      expect(res.keys).to eq([:error])
      expect(res[:error].keys).to eq([:password_confirmation])
      expect(res[:error][:password_confirmation]).to eq(["doesn't match Password"])
    end
    it 'email already in use' do
      uri = api_v1_users_path
      body = {
              "email": "meep@beep.com",
              "password": "bander",
              "password_confirmation": "bander"
              }
      headers = {'CONTENT_TYPE': 'application/json'}

      post uri, headers: headers, params: body, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      res = JSON.parse(response.body, symbolize_names: true)

      expect(res.keys).to eq([:error])
      expect(res[:error].keys).to eq([:email])
      expect(res[:error][:email]).to eq(["has already been taken"])
    end
    it 'password is blank' do
      uri = api_v1_users_path
      body = {
              "email": "ohm@beep.com",
              "password": "",
              "password_confirmation": "bander"
              }
      headers = {'CONTENT_TYPE': 'application/json'}

      post uri, headers: headers, params: body, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      res = JSON.parse(response.body, symbolize_names: true)

      expect(res.keys).to eq([:error])
      expect(res[:error].keys).to eq([:password])
      expect(res[:error][:password].include?("can't be blank")).to eq(true)
    end
    it 'pass conf is blank' do
      uri = api_v1_users_path
      body = {
              "email": "ohm@beep.com",
              "password": "bounder",
              "password_confirmation": ""
              }
      headers = {'CONTENT_TYPE': 'application/json'}

      post uri, headers: headers, params: body, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      res = JSON.parse(response.body, symbolize_names: true)

      expect(res.keys).to eq([:error])
      expect(res[:error].keys).to eq([:password_confirmation])
      expect(res[:error][:password_confirmation].include?("can't be blank")).to eq(true)
    end
    it 'pass conf is blank' do
      uri = api_v1_users_path
      body = {
              "email": "",
              "password": "bounder",
              "password_confirmation": "bounder"
              }
      headers = {'CONTENT_TYPE': 'application/json'}

      post uri, headers: headers, params: body, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      res = JSON.parse(response.body, symbolize_names: true)

      expect(res.keys).to eq([:error])
      expect(res[:error].keys).to eq([:email])
      expect(res[:error][:email].include?("can't be blank")).to eq(true)
    end
  end
end

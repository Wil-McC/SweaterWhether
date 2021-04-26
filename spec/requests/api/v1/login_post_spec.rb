require 'rails_helper'

RSpec.describe 'the login POST request' do
  describe 'happy path' do
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
    it 'returns json payload with email and api key' do
      uri = api_v1_sessions_path
      body = {
              "email": "meep@beep.com",
              "password": "zoomer"
              }
      headers = {'CONTENT_TYPE': 'application/json'}
      post uri, headers: headers, params: body, as: :json

      expect(response).to be_successful
      expect(response.status).to eq(200)

      res = JSON.parse(response.body, symbolize_names: true)

      expect(res).to be_a(Hash)
      expect(res.keys).to eq([:data])
      expect(res[:data].keys).to eq([:id, :type, :attributes])
      expect(res[:data][:id]).to be_a(String)
      expect(res[:data][:type]).to eq('users')
      expect(res[:data][:attributes]).to be_a(Hash)
      expect(res[:data][:attributes].keys).to eq([:email, :api_key])
      expect(res[:data][:attributes][:email]).to be_a(String)
      expect(res[:data][:attributes][:email]).to eq("meep@beep.com")
      expect(res[:data][:attributes][:api_key]).to be_a(String)
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
    it 'returns error when email no match' do
      uri = api_v1_sessions_path
      body = {
              "email": "amp@beep.com",
              "password": "zoomer"
              }
      headers = {'CONTENT_TYPE': 'application/json'}
      post uri, headers: headers, params: body, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      res = JSON.parse(response.body, symbolize_names: true)

      expect(res).to be_a(Hash)
      expect(res.keys).to eq([:error])
      expect(res[:error]).to eq('Provided credentials invalid')
    end
    it 'returns error when password no match' do
      uri = api_v1_sessions_path
      body = {
              "email": "meep@beep.com",
              "password": "oops"
              }
      headers = {'CONTENT_TYPE': 'application/json'}
      post uri, headers: headers, params: body, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      res = JSON.parse(response.body, symbolize_names: true)

      expect(res).to be_a(Hash)
      expect(res.keys).to eq([:error])
      expect(res[:error]).to eq('Provided credentials invalid')
    end
    it 'returns error when nothing match' do
      uri = api_v1_sessions_path
      body = {
              "email": "zzp@beep.com",
              "password": "oops"
              }
      headers = {'CONTENT_TYPE': 'application/json'}
      post uri, headers: headers, params: body, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      res = JSON.parse(response.body, symbolize_names: true)

      expect(res).to be_a(Hash)
      expect(res.keys).to eq([:error])
      expect(res[:error]).to eq('Provided credentials invalid')
    end
  end
end

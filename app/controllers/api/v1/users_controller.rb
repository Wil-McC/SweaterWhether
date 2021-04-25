class Api::V1::UsersController < ApplicationController
  def create
    new_user = User.new(user_params)
    require "pry"; binding.pry
  end


  private

  def user_params
    new_user_params = JSON.parse(request.body.read, symbolize_names: true)
    new_user_params[:email].downcase
    key_gen = SecureRandom.base64
    new_user_params[:api_key] = key_gen
    new_user_params
  end
end

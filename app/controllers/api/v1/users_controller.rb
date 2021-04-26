class Api::V1::UsersController < ApplicationController
  def create
    new_user = User.new(user_attrs)
    if new_user.save
      render json: RegistrationSuccessSerializer.new(new_user), status: 201
    else
      error_parse(new_user.errors)
    end
  end

  def error_parse(error)
    m = error.messages

    render json: ({ error: m }), status: 400
  end


  private

  def user_attrs
    new_user_attrs = JSON.parse(request.body.read, symbolize_names: true)
    new_user_attrs[:email].downcase
    key_gen = SecureRandom.base64
    new_user_attrs[:api_key] = key_gen
    new_user_attrs
  end
end

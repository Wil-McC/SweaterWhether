class Api::V1::SessionsController < ApplicationController
  def login
    user = User.find_by(email: user_attrs[:email])
    if user == nil
      render json: ({ error: 'Provided credentials invalid' }), status: 400
    else
      if user.authenticate(user_attrs[:password])
        render json: SuccessSerializer.new(user), status: 200
      else
        render json: ({ error: 'Provided credentials invalid' }), status: 400
      end
    end
  end

  private

  def user_attrs
    attrs = JSON.parse(request.body.read, symbolize_names: true)
    attrs[:email].downcase
    attrs
  end
end

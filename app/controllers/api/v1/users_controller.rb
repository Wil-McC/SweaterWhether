class Api::V1::UsersController < ApplicationController
  def create
    
  end


  private

  def user_params
    new_user_params = params.require(:user).permit(:email, :password, :password_confirmation)
    new_user_params[:email].downcase
    new_user_params
  end
end

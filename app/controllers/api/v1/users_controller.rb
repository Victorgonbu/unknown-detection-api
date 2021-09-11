class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_token!
  def create
    user = User.new(user_params)
    if user.save
      render_json(UserSerializer, user, 200)
    else
      render_errors(user.errors.full_messages, 422)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

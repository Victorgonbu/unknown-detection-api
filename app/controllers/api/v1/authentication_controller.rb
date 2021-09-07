class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :authenticate_token!
  def create
    user = User.find_by(email: user_params[:email])

    if user && user.password == user_params[:password]
      render_json(UserSerializer, user, 200)
    else
      render_errors(['Invalid email or password'], 422)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end

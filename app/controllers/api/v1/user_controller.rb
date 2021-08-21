class Api::V1::UserController < ApiController
  skip_before_action :authenticate_token!
  def create
    user = User.new(user_params)
    if user.save
      render json: { name: user.name, token: JsonWebToken.encode(sub: user.id) }, status: 200
    else
      render json: { errors: user.errors.full_messages }, status: :unauthorized
    end
  end

  private 

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
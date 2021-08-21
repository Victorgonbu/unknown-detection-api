class UserController < ApiController
  def create
    user = user.new(user_params)

    if user
  end

  private 

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
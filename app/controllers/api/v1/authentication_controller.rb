class Api::V1::AuthenticationController < ApiController
  skip_before_action :authenticate_token!
  def create
    user = User.find_by(email: params[:user][:email])

    if user && user.password == params[:user][:password]
      render json: { name: user.name,
                     email: user.email_name,
                     token: JsonWebToken.encode(sub: user.id) }, status: 200

    else
      render json: { errors: ['Invalid email or password'] }, status: 404
    end
  end
end

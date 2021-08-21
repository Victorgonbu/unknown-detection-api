class Api::V1::AuthenticationController < ApiController
    skip_before_action :authenticate_token!
    def create
        user = User.find_by(email: params[:user][:email])
        
        if user.password == params[:user][:password]
            render json: { name: user.name, token: JsonWebToken.encode(sub: user.id) }
            
        else
            render json: { errors: ["Invalid email or password"]}
        end

    end
end
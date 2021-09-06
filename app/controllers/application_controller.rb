class ApplicationController < ActionController::API
  attr_reader :current_user

  before_action :set_default_format
  before_action :authenticate_token!

  private
  
  def set_default_format
    request.format = :json
  end

  def authenticate_token!
    payload = JsonWebToken.decode(auth_token)
    @current_user = User.find(payload['sub'])
  rescue JWT::ExpiredSignature
    render json: { errors: ['Auth Token has expired'] }, status: :unauthorized
  rescue JWT::DecodeError
    @current_user = nil
  end

  def auth_token
    @auth_token ||= request.headers.fetch('Authorization', '').split.last
  end
end

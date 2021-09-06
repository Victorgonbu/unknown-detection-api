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

  def render_json(serializer, record, status_code, options = {})
    render json: serializer.new(record, options).serializable_hash.to_json, status: status_code
  end

  def render_errors(msgs, status_code)
    render json: {errors: msgs}, status: status_code
  end
end

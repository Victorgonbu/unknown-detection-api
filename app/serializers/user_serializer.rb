class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :email_name

  attribute :token do |user|
    JsonWebToken.encode(sub: user.id)
  end
end

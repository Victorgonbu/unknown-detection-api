class PostSerializer
  include JSONAPI::Serializer
  attributes :title, :description, :location
  has_many :favorites
end

class PostSerializer
  include JSONAPI::Serializer
  attributes :title, :description, :location, :date
end

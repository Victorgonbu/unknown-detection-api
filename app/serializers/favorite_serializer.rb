class FavoriteSerializer
  include JSONAPI::Serializer
  belongs_to :post
  belongs_to :user
end

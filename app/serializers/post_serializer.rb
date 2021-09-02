class PostSerializer
  include JSONAPI::Serializer
  attributes :title, :description, :location
  has_many :favorites
  belongs_to :author, id_method_name: :user_id, serializer: UserSerializer

  attribute :image do |post|
    post.image.variant(resize_to_limit: [500, 500]).processed.service_url if post.image.attached?
  end
  attribute :favorite do |post, params|
    if params[:user_favorites]
      favorite_posts = params[:user_favorites]
      favorite_record = favorite_posts.find { |fav| fav.post_id == post.id }
      favorite_record
    end
  end
end

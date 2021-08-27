class PostSerializer
  include JSONAPI::Serializer
  attributes :title, :description, :location
  has_many :favorites
  belongs_to :author, id_method_name: :user_id, serializer: UserSerializer

  attribute :image do |post|
    if post.image.attached?
      post.image.variant(resize_to_limit:  [500, 500]).processed.service_url
    end
  end
  attribute :favorite do |post, params|
    
    if params[:user_favorites] 
      favorite_posts = params[:user_favorites]
      favorite_record = favorite_posts.find { |fav| fav.post_id == post.id }
      favorite_record
    else
      nil
    end
  end
end

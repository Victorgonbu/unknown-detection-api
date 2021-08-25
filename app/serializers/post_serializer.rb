class PostSerializer
  include JSONAPI::Serializer
  attributes :title, :description, :location
  has_many :favorites

  attribute :image do |post|
    if post.image.attached?
      post.image.variant(resize_to_limit:  [500, 500]).processed.service_url
    end
  end
  attribute :favorite do |post, params|
    
    if params[:user_favorites] 
      favorite_posts = params[:user_favorites]
      is_favorite = favorite_posts.any? { |f_post| f_post.id == post.id }
      is_favorite
    else
      nil
    end
  end
end

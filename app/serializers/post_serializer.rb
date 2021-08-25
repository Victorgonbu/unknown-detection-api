class PostSerializer
  include JSONAPI::Serializer
  attributes :title, :description, :location
  has_many :favorites

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

class Api::V1::FavoritesController < ApiController

  def index
      @favorite_posts = current_user.favorite_posts
      render json: PostSerializer.new(@favorite_posts, { params: { 
        user_favorites: current_user.favorite_posts } }).serializable_hash.to_json, status: 200
  end

  def create
    @favorite = Favorite.new(fav_params);
    if @favorite.save
      render json: FavoriteSerializer.new(@favorite).serializable_hash.to_json, status: 200
    else
      render json: { errors: ['Unable to add post to favorites']}, status: :unauthorized
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    if @favorite.destroy
      render json: { message: 'Post deleted from favorites' }, status: 200
    else
      render json: { errors: ['Unable to delete post from favorites'] }, status: :404
    end
  end

  private

  def fav_params
    params.require(:favorite).permit(:user_id, :post_id)
  end
end
class Api::V1::FavoritesController < ApplicationController
  def index
    if current_user
      @favorite_posts = current_user.favorite_posts
      render json: PostSerializer.new(@favorite_posts, { params: {
                                        user_favorites: current_user.favorites
                                      } }).serializable_hash.to_json, status: 200

    else
      render json: { errors: ['No current user'] }, status: 404
    end
  end

  def create
    if current_user
      @favorite = Favorite.create(fav_params.merge(user_id: current_user.id))
      render json: FavoriteSerializer.new(@favorite).serializable_hash.to_json, status: 200
    else
      render json: { errors: ['Unable to add post to favorites'] }, status: :unauthorized
    end
  end

  def destroy
    if current_user
      @favorite = Favorite.find(params[:id])
      @favorite.destroy
      render json: { message: 'Post deleted from favorites' }, status: 200
    else
      render json: { errors: ['Unable to delete post from favorites'] }, status: 404
    end
  end

  private

  def fav_params
    params.require(:favorite).permit(:post_id)
  end
end

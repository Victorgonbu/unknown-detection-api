class Api::V1::FavoritesController < ApiController

  def index
      @favorite_posts = current_user.favorite_posts
      render json: PostSerializer.new(@favorite_posts).serializable_hash.to_json, status: 200
  end

  private

  def fav_params
    params.require(:favorite).permit(:user_id, :post_id)
  end
end
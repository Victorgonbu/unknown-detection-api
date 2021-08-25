class Api::V1::FavoritesController < ApiController
  def index
      
  end

  private

  def fav_params
    params.require(:favorite).permit(:user_id, :post_id)
  end
end
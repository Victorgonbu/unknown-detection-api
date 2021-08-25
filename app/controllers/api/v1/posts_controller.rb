class Api::V1::PostsController < ApiController
    before_action :set_post, except: [:index]

    def index
        @posts = Post.all.includes(:favorites, image_attachment: :blob)
        render json: PostSerializer.new(@posts, { params: 
            { user_favorites: serlializer_params } }).serializable_hash.to_json, status: 200
    end

    def show 
        if @post.present?
            render json: PostSerializer.new(@post, { params: 
                { user_favorites: serlializer_params } }).serializable_hash.to_json, status: 200 
        else
            render json: {errors: ["Not found"]}, status: 404 
        end
    end

    private

    def serlializer_params
        p 'CURRENT USER'
        p current_user
        current_user ? current_user.favorite_posts : nil
    end
    
    def set_post
        @post = Post.find(params[:id])
    end
end
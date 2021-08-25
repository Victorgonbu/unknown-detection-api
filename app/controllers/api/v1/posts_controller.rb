class Api::V1::PostsController < ApiController
    before_action :set_post

    def show 
        if @post.present?
            render json: PostSerializer.new(@post).serializable_hash.to_json, status: 200 
        else
            render json: {errors: ["Not found"]}, status: 404 
        end
    end

    private
    
    def set_post
        @post = Post.find(params[:id])
    end
end
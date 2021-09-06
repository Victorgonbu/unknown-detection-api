class Api::V1::PostsController < ApplicationController
  before_action :set_post, except: [:index]

  def index
    if params[:search]
      query = params[:search]
      @posts = Post.search(query)
      if @posts.any?
        render_json(PostSerializer ,@posts, 200)
      else
        render_errors(['No matches found'], 404)
      end
    else
      @posts = Post.all_posts
      render_json(PostSerializer, @posts, 200, options)
    end
  end

  def show
    if @post.present?
      render_json(PostSerializer, @post, 200, options(true))
    else
      render_errors(['Not found'], 404)
    end
  end

  private

  def options(include_rel = false)
    {
      params: { user_favorites: serlializer_params },
      include: include_rel ? [:author] : nil 
    }
  end

  def serlializer_params
    current_user ? current_user.favorites : nil
  end

  def set_post
    @post = Post.find(params[:id])
  end
end

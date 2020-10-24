class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def new
  end

  def create
    current_user.like(@post) unless Like.find_by(user: current_user, post: @post)
    redirect_back(fallback_location: posts_path)
  end

  def destroy
    current_user.unlike(@post) if Like.find_by(user: current_user, post: @post)
    redirect_back(fallback_location: posts_path)
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end
end
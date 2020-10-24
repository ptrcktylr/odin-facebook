class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:create]

  before_action :set_comment, only: [:destroy]
  before_action :set_user, only: [:destroy]
  before_action :authorize_current_user, only: [:destroy]

  def create
    @comment = current_user.comment(@post, comment_params[:content])

    if @comment.save
      flash[:notice] = "Comment posted!"
      redirect_back(fallback_location: posts_path)
    else
      flash[:alert] = "Comment post failed!"
      redirect_back(fallback_location: posts_path)
    end
  end

  def destroy
    if @comment.destroy
      redirect_back fallback_location: posts_path, notice: "Comment removed!"
    else
      redirect_back fallback_location: posts_path, alert: "Failed to remove comment!"
    end
  end


  private
  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.includes(:author).find(params[:id])
  end

  def set_user
    @user = @comment.author
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
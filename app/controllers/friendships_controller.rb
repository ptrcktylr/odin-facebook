class FriendshipsController < ApplicationController
  # current user id, friend id that i'm requesting
  before_action :set_user, only: [:index]
  

  def index
    @friendships = Friendship.where(user_id: @user.id).select{ |fr| fr.mutual? }
  end

  def new
  end

  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save && @friendship.mutual?
      flash[:notice] = "Added friend!"
      redirect_back(fallback_location: root_path)
    elsif
      flash[:notice] = "Friend request sent!"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Unable to add friend!"
      redirect_back(fallback_location: root_path)
    end
  end

  def show
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end
end
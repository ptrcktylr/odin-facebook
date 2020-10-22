class FriendshipsController < ApplicationController
  # current user id, friend id that i'm requesting

  def index
    @friendships = Friendship.all
  end

  def new
  end

  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added friend!"
      redirect_to current_user
    else
      flash[:alert] = "Unable to add friend!"
      redirect_to current_user
    end
  end

  def show
  end

end
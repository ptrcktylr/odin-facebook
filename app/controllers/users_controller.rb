class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: [:index]
  before_action :authorize_current_user, except: [:index, :show]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(profile_params)
      redirect_to @user, notice: 'Successfully updated!'
    else
      flash.now[:alert] = 'Update failed.'
      render 'edit'
    end
  end

  def remove_avatar
    # delete attached avatar 
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def profile_params
    params.require(:user).permit(:name, :summary, :avatar) #:avatar 
  end
end
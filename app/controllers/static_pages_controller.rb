class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: [:friend_requests]

  def home
  end
  
end

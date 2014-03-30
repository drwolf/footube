class UsersController < ApplicationController

  before_action :find_user

  def show
  end

  def videos
    if current_user?
      @videos = @user.videos.page(params[:page] || 1)
    else
      @videos = @user.videos.published.page(params[:page] || 1)
    end
  end

  private

  def current_user?
    params[:id].nil?
  end

  def find_user
    if current_user?
      @user = current_user
    else
      @user = User.find(params[:id])
    end
  end

end

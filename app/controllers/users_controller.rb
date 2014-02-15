class UsersController < ApplicationController

  before_action :find_user

  def show
  end

  def videos
    @videos = @user.videos.page(params[:page] || 1)
  end

  private

  def find_user
    @user = User.find(params[:id] || current_user.id)
  end

end

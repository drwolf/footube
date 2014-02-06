class VideosController < ApplicationController

  def index
    @videos = User.find(params[:user_id]).videos.all
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
  end

  def delete
  end

  def destroy
  end

end

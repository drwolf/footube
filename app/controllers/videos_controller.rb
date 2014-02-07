class VideosController < ApplicationController

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @videos = @user.videos.all
    else
      @videos = Video.all
    end
  end

  def new
    @video = Video.new user: current_user
  end

  def create
    video = Video.new video_params
    video.user = current_user
    video.file = File.open(params[:video][:file].tempfile)
    video.save!
    redirect_to root_path, notice: 'ok'
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

  private

  def video_params
    params.require(:video).permit(:title, :description)
  end

end
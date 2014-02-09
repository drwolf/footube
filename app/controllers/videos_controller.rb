class VideosController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show]

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @videos = @user.videos.page(params[:page] || 1)
    else
      @videos = Video.page(params[:page] || 1)
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
    VideoConverter.perform_async(video.id.to_s, '320x195')
    VideoConverter.perform_async(video.id.to_s, '640x480')
    redirect_to root_path, notice: 'ok'
  end

  def edit
  end

  def update
  end

  def show
    @video = Video.find(params[:id])
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

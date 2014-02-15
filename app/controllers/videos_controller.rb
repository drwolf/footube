class VideosController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @videos = Video.page(params[:page] || 1)
  end

  def new
    @video = Video.new user: current_user
  end

  def create
    video = Video.new video_params
    video.user = current_user
    video.file = File.open(params[:video][:file].tempfile)
    video.save!
    Video::RESOLUTIONS.each do |resolution|
      VideoConverter.perform_async(video.id.to_s, resolution)
    end
    redirect_to root_path, notice: 'ok'
  end

  def edit
  end

  def update
  end

  def show
    @video = Video.find(params[:video_id] || params[:id])
    @version = params[:version_id] ? @video.versions.find(params[:version_id]) : @video.versions.first
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

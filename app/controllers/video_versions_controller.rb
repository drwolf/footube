class VideoVersionsController < ApplicationController

  respond_to :json

  def progress
    video = Video.find(params[:video_id])
    @version = video.versions.find(params[:version_id])
    render json: { progress: @version.progress }
  end

end

class VideoConverter

  include Sidekiq::Worker

  def perform(video_id, resolution)
    Video.unscoped do
      video = Video.find(video_id)
      FileUtils.mkdir_p video.screenshot_path(resolution).dirname
      movie = FFMPEG::Movie.new(video.file.path)
      movie.screenshot(video.screenshot_path(resolution), seek_time: 5, resolution: resolution)
      movie.transcode(video.movie_path(resolution), resolution: resolution)
      video.processed = true
      video.save
    end
  end

end
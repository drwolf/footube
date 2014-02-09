class VideoConverter
  include Sidekiq::Worker

  def perform(video_id, resolution)
    video = Video.find(video_id)
    FileUtils.mkdir_p video.screenshot_path(resolution).dirname
    movie = FFMPEG::Movie.new(video.file.path)
    movie.screenshot(video.screenshot_path(resolution), seek_time: 5, resolution: resolution)
  end

end
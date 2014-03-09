class VideoConverter

  include Sidekiq::Worker

  def perform(video_id, resolution)
    Video.unscoped do
      video = Video.find(video_id)
      FileUtils.mkdir_p video.screenshot_path(resolution).dirname
      FileUtils.mkdir_p video.movie_path(resolution).dirname
      if video.versions.where(resolution: resolution).any?
        raise "version #{resolution} already exists for video #{video_id}"
      end
      version = video.versions.create resolution: resolution
      movie = FFMPEG::Movie.new(video.file.path)
      movie.screenshot(video.screenshot_path(resolution), seek_time: 5, resolution: resolution)
      movie.transcode(video.movie_path(resolution), resolution: resolution) do |progress|
        progress = (progress * 100).round
        if progress % 5 == 0 && version.progress != progress
          version.progress = progress
          version.save
        end
      end
      version.progress = 100
      version.processed = true
      version.save
      video.processed = true
      video.save
    end
  end

end
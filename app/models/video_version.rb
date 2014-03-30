class VideoVersion

  include Mongoid::Document
  include Mongoid::Timestamps

  field :resolution, type: String
  field :processed, type: Boolean
  field :progress, type: Integer, default: 0

  embedded_in :video

  def screenshot_url
    video.screenshot_url(resolution)
  end

  def movie_url
    video.movie_url(resolution)
  end

end

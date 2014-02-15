class VideoVersion

  include Mongoid::Document
  include Mongoid::Timestamps

  field :resolution, type: String
  field :processed, type: Boolean, default: 0.0
  field :progress, type: Float

  embedded_in :video

  default_scope -> { where(processed: true) }

  # this is so ridiculous
  # (https://github.com/mongoid/mongoid/issues/2218)
  after_initialize do |doc|
    doc.processed = false unless doc.progress
  end

  def screenshot_url
    video.screenshot_url(resolution)
  end

  def movie_url
    video.movie_url(resolution)
  end

end

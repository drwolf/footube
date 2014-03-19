class VideoVersion

  include Mongoid::Document
  include Mongoid::Timestamps

  field :resolution, type: String
  field :processed, type: Boolean
  field :progress, type: Integer, default: 0

  embedded_in :video

  default_scope -> { where(processed: true) }

  # this is so ridiculous
  # (https://github.com/mongoid/mongoid/issues/2218)
  after_initialize do |doc|
    doc.processed = false if doc.progress == 0
  end

  def screenshot_url
    video.screenshot_url(resolution)
  end

  def movie_url
    video.movie_url(resolution)
  end

end

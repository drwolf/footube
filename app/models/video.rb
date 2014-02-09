class Video

  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String
  field :file, type: String
  field :processed, type: Boolean

  belongs_to :user

  mount_uploader :file, VideoUploader

  paginates_per 27

  default_scope -> { where(processed: true) }

  def screenshot_path(resolution)
    Rails.root.join 'public', 'videos', id.to_s, resolution, 'screenshot.png'
  end

  def screenshot_url(resolution)
    "/videos/#{id.to_s}/#{resolution}/screenshot.png"
  end

  def movie_path(resolution)
    Rails.root.join 'public', 'videos', id.to_s, resolution, 'movie.mp4'
  end

  def movie_url(resolution)
    "/videos/#{id.to_s}/#{resolution}/screenshot.mp4"
  end

end

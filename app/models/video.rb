class Video

  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String
  field :file, type: String
  field :processed, type: Boolean

  belongs_to :user
  embeds_many :versions, class_name: 'VideoVersion'

  mount_uploader :file, VideoUploader

  paginates_per 27

  default_scope -> { where(processed: true) }

  RESOLUTIONS = %w{320x200 640x480 1920x1080}

  # this is so ridiculous
  # (https://github.com/mongoid/mongoid/issues/2218)
  after_initialize do |doc|
    doc.processed = false
  end

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
    "/videos/#{id.to_s}/#{resolution}/movie.mp4"
  end

  def self.create_missing_versions
    Video.unscoped.all.each do |video|
      RESOLUTIONS.each do |resolution|
        next if video.versions.unscoped.where(resolution: resolution).any?
        VideoConverter.perform_async(video.id.to_s, resolution)
      end
    end
  end

end

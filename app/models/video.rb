class Video

  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String
  field :file, type: String
  field :processed, type: Boolean, default: false

  belongs_to :user
  embeds_many :versions, class_name: 'VideoVersion'

  accepts_nested_attributes_for :versions

  mount_uploader :file, VideoUploader

  paginates_per 27

  RESOLUTIONS = %w{320x200 640x480 1920x1080}

  scope :published, -> { where(processed: true) }

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
    Video.all.each do |video|
      RESOLUTIONS.each do |resolution|
        next if video.versions.where(resolution: resolution).any?
        VideoConverter.perform_async(video.id.to_s, resolution)
      end
    end
  end

end

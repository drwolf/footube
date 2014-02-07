class Video

  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String
  field :file, type: String
  field :processed, type: Boolean

  belongs_to :user

  mount_uploader :file, VideoUploader

end

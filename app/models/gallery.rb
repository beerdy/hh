class Gallery
  include Mongoid::Document
  include Mongoid::Paperclip

  field :title, type: String
  field :description, type: String
  field :slave, type: String
  field :url, type: String
  field :link, type: String
  field :sort, type: Integer

  has_mongoid_attached_file :image,
    :styles => {
      :thumb => "320x240#",
      :medium => "800x600#"
    }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
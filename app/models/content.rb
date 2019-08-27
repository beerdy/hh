class Content
  include Mongoid::Document
  include Mongoid::Paperclip

  field :title, type: String
  field :description, type: String
  field :slave, type: String
  field :image, type: String
  field :link, type: String
  field :tag, type: String
  field :url, type: String
  field :link, type: String
  field :sort, type: Integer
  field :count, type: Integer
  
  has_mongoid_attached_file :document
  validates_attachment_content_type :document, :content_type => ["application/pdf"]
end

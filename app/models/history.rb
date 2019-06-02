class History
  include Mongoid::Document
  # field :title, type: String
  # field :description, type: String
  # field :slave, type: String
  # field :image, type: String
  # field :link, type: String
  # field :tag, type: String
  # field :url, type: String
  # field :link, type: String
  # field :sort, type: Integer
  # field :count, type: Integer

  field :cardIdFrom, type: String
  field :cardIdTo,   type: String
  field :sum,        type: Integer
  field :time, type: Integer
  field :user_id, type: BSON::ObjectId

  belongs_to :user
end
class Reservation
  include Mongoid::Document
  field :name, type: String
  field :phone, type: String
  field :email, type: String
  field :description, type: String
  field :user_id, type: BSON::ObjectId

  belongs_to :user
end

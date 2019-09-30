class Reservation
  include Mongoid::Document
  field :date, type: String
  field :time, type: String
  field :room, type: String
  field :person, type: Integer
  field :name, type: String
  field :phone, type: String
  field :email, type: String
  field :description, type: String
  field :user_id, type: BSON::ObjectId

  belongs_to :user
end

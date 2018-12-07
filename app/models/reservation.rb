class Reservation
  include Mongoid::Document
  field :name, type: String
  field :phone, type: String
  field :email, type: String
  field :description, type: String
  field :user_id, type: Integer

  belongs_to :user
end

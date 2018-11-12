class Order
  include Mongoid::Document

  field :title, type: String
  field :description, type: String
  field :image, type: String
  field :name, type: String
  field :email, type: String
  field :address, type: String

  field :products, type: Array, default: []
  field :user_id, type: String
end

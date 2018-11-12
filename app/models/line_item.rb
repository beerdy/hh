class LineItem
  include Mongoid::Document
  field :quantity, type: Integer
  field :product_id, type: Integer
  field :cart_id, type: Integer
  field :order_id, type: Integer
end

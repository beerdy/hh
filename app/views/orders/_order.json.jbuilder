json.extract! order, :id, :title, :description, :image, :name, :email, :address, :created_at, :updated_at
json.url order_url(order, format: :json)

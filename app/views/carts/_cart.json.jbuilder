json.extract! cart, :id, :title, :description, :slave, :image, :link, :tag, :url, :link, :sort, :count, :created_at, :updated_at
json.url cart_url(cart, format: :json)

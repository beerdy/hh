json.extract! message, :id, :title, :description, :slave, :image, :link, :tag, :url, :link, :sort, :count, :created_at, :updated_at
json.url message_url(message, format: :json)

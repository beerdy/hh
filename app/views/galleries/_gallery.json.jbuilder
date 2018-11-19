json.extract! gallery, :id, :title, :description, :slave, :url, :link, :sort, :image_updated_at
json.url gallery_url(gallery, format: :json)

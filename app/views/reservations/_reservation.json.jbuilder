json.extract! reservation, :id, :name, :phone, :email, :description, :user, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)

json.extract! review, :id, :name, :phone, :email, :description, :user_id, :created_at, :updated_at
json.url review_url(review, format: :json)

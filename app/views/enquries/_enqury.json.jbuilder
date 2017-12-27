json.extract! enqury, :id, :full_name, :email, :phone, :message, :created_at, :updated_at
json.url enqury_url(enqury, format: :json)

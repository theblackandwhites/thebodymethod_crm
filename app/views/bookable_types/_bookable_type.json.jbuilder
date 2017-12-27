json.extract! bookable_type, :id, :title, :description, :created_at, :updated_at
json.url bookable_type_url(bookable_type, format: :json)

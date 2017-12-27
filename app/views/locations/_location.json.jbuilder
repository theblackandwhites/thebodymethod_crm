json.extract! location, :id, :name, :address, :city, :zipcode, :state, :country, :phone_number, :email_address, :created_at, :updated_at
json.url location_url(location, format: :json)

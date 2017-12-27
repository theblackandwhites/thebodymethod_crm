json.extract! instructor, :id, :first_name, :last_name, :gender, :dob, :address, :city, :state, :zipcode, :country, :phone, :phone2, :email, :bio, :created_at, :updated_at
json.url instructor_url(instructor, format: :json)

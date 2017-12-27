json.extract! bookable, :id, :date_start, :time_start, :time_start_unit, :time_finish, :time_finish_unit, :bookable_type_id, :location_id, :instructor_id, :price, :pay_cash, :pay_online, :pay_points, :created_at, :updated_at
json.url bookable_url(bookable, format: :json)

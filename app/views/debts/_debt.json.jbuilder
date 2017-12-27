json.extract! debt, :id, :user_id, :bookable_id, :participant_id, :amount, :created_at, :updated_at
json.url debt_url(debt, format: :json)

class Debt < ApplicationRecord
  belongs_to :user
  belongs_to :bookable
  belongs_to :participant
end

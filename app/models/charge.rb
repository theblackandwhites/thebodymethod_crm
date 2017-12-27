class Charge < ApplicationRecord
  belongs_to :user
  belongs_to :bookable
  belongs_to :bookable_type
  has_many :participants

end

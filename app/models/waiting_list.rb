class WaitingList < ApplicationRecord
  belongs_to :user
  belongs_to :bookable
end

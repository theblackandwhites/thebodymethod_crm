class Participant < ApplicationRecord
  belongs_to :bookable
  belongs_to :user
  belongs_to :charge
end

class Qualification < ApplicationRecord
  belongs_to :instructor, required: false
end

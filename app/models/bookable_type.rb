class BookableType < ApplicationRecord
	has_many :bookables
	has_many :charges
	has_attachment  :featured_image, accept: [:jpg, :png, :gif]
	validates :featured_image, presence: false
end

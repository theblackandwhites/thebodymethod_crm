class Location < ApplicationRecord

	has_many :bookables

	has_attachment  :featured_image, accept: [:jpg, :png, :gif]
	has_attachments :photos, maximum: 10
	validates :featured_image, presence: true

	# GEOCoder
	def full_address
    	"#{address} #{city} #{state}, #{country} #{zipcode}"
  	end
	geocoded_by :full_address   # can also be an IP address
	after_validation :geocode          # auto-fetch coordinates

end

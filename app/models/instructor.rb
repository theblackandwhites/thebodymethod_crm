class Instructor < ApplicationRecord
	has_many :bookables
	has_many :qualifications
	accepts_nested_attributes_for :qualifications

	has_attachment  :avatar, accept: [:jpg, :png, :gif]
	validates :avatar, presence: true
	
	def full_name
    	"#{first_name} #{last_name}"
  	end

end

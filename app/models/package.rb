class Package < ApplicationRecord
	has_many :user_packages, dependent: :destroy
	has_many :users, through: :user_packages
end

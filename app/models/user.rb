class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :participants
  has_many :points
  has_many :user_packages, dependent: :destroy
  has_many :packages, through: :user_packages
  has_many :walkins
  
end

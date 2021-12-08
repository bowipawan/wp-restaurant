class User < ApplicationRecord
	has_secure_password
	validates(:email, presence: true, uniqueness: true)
	validates(:display_name, presence: true)
	validates(:password_digest, presence: true)
	validates_confirmation_of :password
	has_many :appointments, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :likes, dependent: :destroy
end

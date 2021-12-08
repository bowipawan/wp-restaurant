class User < ApplicationRecord
	has_secure_password
	validates(:email, presence: true, uniqueness: true)
	validates(:display_name, presence: true)
	validates(:password_digest, presence: true)
	validates_confirmation_of :password
	has_many :appointments, dependent: :delete_all
	has_many :comments, dependent: :delete_all
	has_many :favorites, dependent: :delete_all
	has_many :likes, dependent: :delete_all
end

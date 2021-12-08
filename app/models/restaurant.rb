class Restaurant < ApplicationRecord
	has_many :tables, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :rates, dependent: :destroy
end

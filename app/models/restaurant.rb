class Restaurant < ApplicationRecord
	has_many :tables, dependent: :delete_all
	has_many :comments, dependent: :delete_all
	has_many :rates, dependent: :delete_all
end

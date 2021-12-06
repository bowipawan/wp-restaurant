class Table < ApplicationRecord
  belongs_to :restaurant
  has_many :appointments, dependent: :delete_all
end

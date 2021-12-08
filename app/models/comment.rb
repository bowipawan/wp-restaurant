class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :likes, dependent: :destroy
end

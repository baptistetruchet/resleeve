class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :body
  has_many :reviews
end

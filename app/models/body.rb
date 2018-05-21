class Body < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :reviews, through: :bookings

  validates :price_per_day, presence: true, numericality: { :greater_than_or_equal_to => 0 }
  validates :sex, presence: true, inclusion: { in: ["M", "F"] }
  validates :location, presence: true, allow_blank: false
  validates :title, presence: true, allow_blank: false

  def owner
    user
  end
end

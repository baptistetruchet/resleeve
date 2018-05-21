class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :body
  has_many :reviews

  validates :date_in, presence: true, allow_blank: false
  validates :date_out, presence: true, allow_blank: false
  validates :status, inclusion: { in: ["pending", "accepted", "refused", "cancelled"] }

  def owner
    body.user
  end

  def renter
    user
  end
end

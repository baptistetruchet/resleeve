class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :body
  has_many :conversations, dependent: :destroy
  has_many :reviews, dependent: :destroy

  # before_validation(on: :create) do
  #   :set_default_status
  # end

  before_save :check_dates
  validates :date_in, presence: true, allow_blank: false
  validates :date_out, presence: true, allow_blank: false
  validates :status, inclusion: { in: ["pending", "accepted", "refused", "cancelled"] }

  def owner
    body.user
  end

  def renter
    user
  end

  private

  # def set_default_status
  #   self.status = "pending"
  # end

  def check_dates
    dates_already_booked = [date_in, date_out]
    body.bookings.each do |b|
      dates_already_booked << b.date_in
      dates_already_booked << b.date_out
    end
    dates_already_booked.sort!
    idx_in = dates_already_booked.index(date_in)
    idx_out = dates_already_booked.index(date_out)
    if idx_in + 1 == idx_out && idx_in % 2 == 0
      true
    else
      throw(:abort)
    end
  end
end

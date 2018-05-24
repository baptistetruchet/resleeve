class Body < ApplicationRecord
  geocoded_by :location
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings

  mount_uploader :photo, PhotoUploader

  validates :price_per_day, presence: true, numericality: { :greater_than_or_equal_to => 0 }
  validates :sex, presence: true, inclusion: { in: ["M", "F", "T"] }
  validates :location, presence: true, allow_blank: false
  validates :title, presence: true, allow_blank: false
  after_validation :geocode, if: :will_save_change_to_location?

  def owner
    user
  end

  def rating
    return 0 if reviews.length == 0
    reviews.map(&:rating).sum / reviews.length
  end

  def forbidden_dates
    str = ""
    bookings.each do |b|
      str += b.date_in.to_s + "|"
      str += b.date_out.to_s + "X"
    end
    str.chop
  end
end

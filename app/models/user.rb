class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :bookings
  has_many :messages
  has_many :bodies, dependent: :destroy

  mount_uploader :photo, PhotoUploader

  validates :first_name, presence: true, allow_blank: false
  validates :last_name, presence: true, allow_blank: false

  def new_messages
    Message.where(receiver: self).where(viewed: false).count
    # messages.count { |msg| msg.receiver == self && msg.viewed? == false }
  end
end

class Message < ApplicationRecord
  belongs_to :booking
  belongs_to :receiver, class_name: "User"
  belongs_to :sender, class_name: "User"

  validates :content, presence: true, allow_blank: false
  validates :sender, presence: true
  validates :receiver, presence: true
  validates :booking, presence: true
end

class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :receiver, class_name: "User"
  belongs_to :sender, class_name: "User"

  validates :content, presence: true, allow_blank: false
  validates :sender, presence: true
  validates :receiver, presence: true
  validates :conversation, presence: true
end

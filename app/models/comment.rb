class Comment < ApplicationRecord

  belongs_to :coordinate
  belongs_to :user
  has_many :notifications, dependent: :destroy

  validates :comment, presence: true, length:{in: 2..250}
end

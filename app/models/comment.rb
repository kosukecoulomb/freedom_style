class Comment < ApplicationRecord
  
  #アソシエーション
  belongs_to :coordinate
  belongs_to :user
  has_many :notifications, dependent: :destroy
  

end

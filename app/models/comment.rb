class Comment < ApplicationRecord
  
  #アソシエーション
  belongs_to :coordinate
  belongs_to :user
  
end

class TagMap < ApplicationRecord
  
  #バリデーション
  belongs_to :coordinate
  belongs_to :tag
  
  #バリデーション
  validates :coordinate_id, presence: true
  validates :tag_id, presence: true
  
end

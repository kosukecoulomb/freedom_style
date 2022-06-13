class Tag < ApplicationRecord
  
  #バリデーション
  has_many :tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :coordinates, through: :tag_maps
  
end

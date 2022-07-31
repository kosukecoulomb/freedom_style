class Tag < ApplicationRecord
  has_many :tag_maps, dependent: :destroy
  has_many :coordinates, through: :tag_maps
  
  scope :popularity, -> (count) { 
    limit(count).find(TagMap.group(:tag_id).order('count(tag_id) desc').pluck(:tag_id))
  }
end

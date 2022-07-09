class Tag < ApplicationRecord
  # バリデーション
  has_many :tag_maps, dependent: :destroy
  has_many :coordinates, through: :tag_maps
end

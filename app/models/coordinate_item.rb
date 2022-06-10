class CoordinateItem < ApplicationRecord
  belongs_to :coordinate
  has_many :items
end

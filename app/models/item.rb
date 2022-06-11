class Item < ApplicationRecord
  #アソシエーション
  belongs_to :user
  has_many :coordinates
  
  #画像投稿
  has_one_attached :item_image

  def get_item_image(width, height)
    item_image.variant(resize_to_limit: [width, height]).processed
  end
  
  #バリデーション
  validates :item_image, presence:true
  validates :user_id, presence: true
  validates :item_name, presence: true
  validates :size, presence: true
  validates :color, presence: true
  validates :price, presence: true
  validates :brand_name, presence: true
  
  #enum
  enum category: { outer:0, tops:1, bottoms:2, shoes:3, others:4  }
end

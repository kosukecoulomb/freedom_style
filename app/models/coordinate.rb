class Coordinate < ApplicationRecord
  
  #アソシエーション
  belongs_to :user
  has_one :coordinate_item, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  
  #いいね機能
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  
  #画像投稿
  has_one_attached :coordinate_image

  def get_coordinate_image(width, height)
    coordinate_image.variant(resize_to_limit: [width, height]).processed
  end
  
  #バリデーション
  validates :coordinate_image, presence:true
  validates :user_id, presence: true
  validates :title, presence: true, length:{in: 2..20}
  validates :body, presence: true, length:{in: 2..250}
  validates :dress_code, presence: true
  validates :season, presence: true
  validates :temperature, presence: true
  
  #enum
  enum dress_code: { casual:0, clean:1, formal:2,  }
  enum season: { spring:0, summer:1, autumn:2, winter:3 }
  enum temperature: { under_ten:0, eleven_fifteen:1, sixteen_twenty:2, twentyone_five:3, over_twentysix:4 }
  
end

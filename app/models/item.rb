class Item < ApplicationRecord
  # アソシエーション
  belongs_to :user
  has_many :coordinates

  # 画像投稿
  has_one_attached :item_image

  def get_item_image(width, height)
    item_image.variant(resize_to_limit: [width, height]).processed
  end

  # 条件検索機能
  scope :search, -> (search_params) do
    return if search_params.blank?

    category_choise(search_params[:category]).
      word_like(search_params[:keyword]).
      price_from_like(search_params[:price_from]).
      price_to_like(search_params[:price_to])
  end
  scope :category_choise, -> (category) { where(category: category) if category.present? }
  scope :word_like, -> (keyword) {where('item_name LIKE ? OR brand_name LIKE? OR color LIKE?',
 "%#{keyword}%", "%#{keyword}%", "%#{keyword}%") if keyword.present?
                         }
  scope :price_from_like, -> (price_from) { where("price >= ?", price_from) if price_from.present? }
  scope :price_to_like, -> (price_to) { where("price < ?", price_to) if price_to.present? }

  # バリデーション
  validates :item_image, presence: true
  validates :category, presence: true
  validates :user_id, presence: true
  validates :item_name, presence: true
  validates :size, presence: true
  validates :color, presence: true
  validates :price, presence: true
  validates :brand_name, presence: true

  # enum
  enum category: { outer: 0, tops: 1, bottoms: 2, shoes: 3, others: 4 }
end

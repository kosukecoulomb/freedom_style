class Coordinate < ApplicationRecord

  #アソシエーション
  belongs_to :user
  has_many :items
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  accepts_nested_attributes_for :tags


  #いいね機能
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  #条件検索機能
  scope :search, -> (search_params) do
    return if search_params.blank?

    dress_code_choise(search_params[:dress_code])
    .season_choise(search_params[:season])
    .temperature_choise(search_params[:temperature])
    .title_body_like(search_params[:title])
  end

  scope :dress_code_choise, -> (dress_code) {where(dress_code: dress_code) if dress_code.present?}
  scope :season_choise, -> (season) {where(season: season) if season.present?}
  scope :temperature_choise, -> (temperature) {where(temperature: temperature) if temperature.present?}
  scope :title_body_like, -> (title) {where('title LIKE ? OR body LIKE?', "%#{title}%","%#{title}%") if title.present?}

  #キーワード検索機能
  #def self.search(search)
    #if search
      #where(['title LIKE ? OR body LIKE?', "%#{search}%", "%#{search}%"]) #検索とtitleまたはbodyの部分一致を表示。
    #else
      #all #全て表示させる
    #end
  #end

  #タグ検索用
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_coordinate_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_coordinate_tag
    end
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
  enum dress_code: { casual:0, clean:1, formal:2 }
  enum season: { spring:0, summer:1, autumn:2, winter:3 }
  enum temperature: { under_ten:0, eleven_fifteen:1, sixteen_twenty:2, twentyone_five:3, over_twentysix:4 }

end

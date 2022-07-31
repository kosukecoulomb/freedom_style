class Coordinate < ApplicationRecord
  # 絞り込みメソッド
  scope :latest, -> (count) { limit(count).order(created_at: :desc) }
  scope :my_favorites, -> (user) do
    favorites = Favorite.where(user_id: user.id).pluck(:coordinate_id)
    order(created_at: :desc).find(favorites)
  end

  # アソシエーション
  belongs_to :user
  has_many :items
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  accepts_nested_attributes_for :tags
  has_many :notifications, dependent: :destroy

  # いいね機能
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 条件検索機能
  scope :search, -> (search_params) do
    return if search_params.blank?

    dress_code_choise(search_params[:dress_code]).
      season_choise(search_params[:season]).
      temperature_choise(search_params[:temperature]).
      word_like(search_params[:keyword]).
      gender_choise(search_params[:gender]).
      generation_choise(search_params[:generation]).
      body_shape_choise(search_params[:body_shape]).
      tall_from_like(search_params[:tall_from]).
      tall_to_like(search_params[:tall_to])
  end

  scope :dress_code_choise, -> (dress_code) { where(dress_code: dress_code) if dress_code.present? }
  scope :season_choise, -> (season) { where(season: season) if season.present? }
  scope :temperature_choise, -> (temperature) { where(temperature: temperature) if temperature.present? }
  scope :word_like, -> (keyword) {
    where('title LIKE ? OR body LIKE?', "%#{keyword}%", "%#{keyword}%") if keyword.present?
    }
  # アソシエーションするユーザーモデルからも検索できるように
  scope :gender_choise, -> (gender) { joins(:user).merge(User.where(gender: gender)) if gender.present? }
  scope :generation_choise, -> (generation) { joins(:user).merge(User.where(generation: generation)) if generation.present? }
  scope :body_shape_choise, -> (body_shape) { joins(:user).merge(User.where(body_shape: body_shape)) if body_shape.present? }
  scope :tall_from_like, -> (tall_from) { joins(:user).merge(User.where(" tall >= ?", tall_from)) if tall_from.present? }
  scope :tall_to_like, -> (tall_to) { joins(:user).merge(User.where("tall < ?", tall_to)) if tall_to.present? }

  # タグ検索用
  def save_tag(sent_tags)
    current_tags = tags.pluck(:tag_name) unless tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      tags.delete Tag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_coordinate_tag = Tag.find_or_create_by(tag_name: new)
      tags << new_coordinate_tag
    end
  end

  # 通知機能
  # いいねの通知
  def create_notification_favorite(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and coordinate_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        coordinate_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      notification.save
    end
  end

  # コメントの通知
  def create_notification_comment(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(coordinate_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      coordinate_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    notification.save
  end

  # 画像投稿
  has_one_attached :coordinate_image

  def get_coordinate_image(width, height)
    coordinate_image.variant(resize_to_limit: [width, height]).processed
  end

  # バリデーション
  validates :coordinate_image, presence: true
  validates :user_id, presence: true
  validates :title, presence: true, length: { in: 2..20 }
  validates :body, presence: true, length: { in: 2..250 }
  validates :dress_code, presence: true
  validates :season, presence: true
  validates :temperature, presence: true

  # enum
  enum dress_code: { casual: 0, clean: 1, formal: 2 }
  enum season: { spring: 0, summer: 1, autumn: 2, winter: 3 }
  enum temperature: { under_ten: 0, eleven_fifteen: 1, sixteen_twenty: 2, twentyone_five: 3, over_twentysix: 4 }
end

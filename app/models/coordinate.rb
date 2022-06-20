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
    .gender_choise(search_params[:gender])
    .generation_choise(search_params[:generation])
    .body_shape_choise(search_params[:body_shape])
  end

  scope :dress_code_choise, -> (dress_code) {where(dress_code: dress_code) if dress_code.present?}
  scope :season_choise, -> (season) {where(season: season) if season.present?}
  scope :temperature_choise, -> (temperature) {where(temperature: temperature) if temperature.present?}
  scope :title_body_like, -> (title) {where('title LIKE ? OR body LIKE?', "%#{title}%","%#{title}%") if title.present?}
  #アソシエーションするユーザーモデルからも検索できるように
  scope :gender_choise, -> (gender) {joins(:user).merge(User.where(gender: gender)) if gender.present?}
  scope :generation_choise, -> (generation) {joins(:user).merge(User.where(generation: generation)) if generation.present?}
  scope :body_shape_choise, -> (body_shape) {joins(:user).merge(User.where(body_shape: body_shape)) if body_shape.present?}

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


  #通知機能
  has_many :notifications, dependent: :destroy

  #いいねの通知
  def create_notification_favorite!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and coordinate_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        coordinate_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  #コメントの通知
  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(coordinate_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      coordinate_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
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

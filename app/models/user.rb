class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #ゲストログイン機能
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
      user.gender = 2
      user.generation = 2
      user.tall = 165
      user.body_shape = 1
      user.foot_size = 25
    end
  end


  #アソシエーション
  has_many :coordinates, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  #フォロー機能
  has_many :relationships, foreign_key: :following_id
  has_many :followings, through: :relationships, source: :follower

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :reverse_of_relationships, source: :following

  def is_followed_by?(user)
    reverse_of_relationships.find_by(following_id: user.id).present?
  end


  #条件検索機能
  scope :search, -> (search_params) do
    return if search_params.blank?

    gender_choise(search_params[:gender])
    .generation_choise(search_params[:generation])
    .body_shape_choise(search_params[:body_shape])
    .name_like(search_params[:name])
  end

  scope :gender_choise, -> (gender) {where(gender: gender) if gender.present?}
  scope :generation_choise, -> (generation) {where(generation: generation) if generation.present?}
  scope :body_shape_choise, -> (body_shape) {where(body_shape: body_shape) if body_shape.present?}
  scope :name_like, -> (name) {where('name LIKE? OR introduction LIKE?', "%#{name}%","%#{name}%") if name.present?}

  #タグ検索
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  

  #通知機能
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  
  #フォロー機能の通知
  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
  

  #画像投稿
  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end


  #バリデーション
  validates :name, presence: true, length:{in: 2..20}
  validates :email, presence: true, uniqueness: true
  validates :gender, presence: true
  validates :generation, presence: true
  validates :tall, presence: true
  validates :body_shape,  presence: true
  validates :foot_size,  presence: true


  #enum
  enum gender: { man:0, woman:1, genderless:2, other:3 }
  enum generation: { teens:0, twenties:1, thirties:2, forties:3, over_fifties:4 }
  enum body_shape: { slender:0, normal:1, fat:2, solid:3 }

end

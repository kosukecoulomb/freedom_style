class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  #アソシエーション
  has_many :coordinates, dependent: :destroy

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
  validates :profile_image, presence: true
  validates :name, presence: true, length:{in: 2..20}
  validates :email, presence: true, uniqueness: true
  validates :introduction, presence: true, length:{in: 2..140}
  validates :gender, presence: true
  validates :generation, presence: true
  validates :tall, presence: true
  validates :body_shape,  presence: true
  validates :foot_size,  presence: true


  #enum
  enum gender: { man:0, woman:1, other:2, do_not_answer:3 }
  enum generation: { teens:0, twenties:1, thirties:2, forties:3, over_fifties:4 }
  enum body_shape: { slender:0, normal:1, fat:2, solid:3 }
  enum foot_size: { two:0, three:1, four:2, five:3, six:4, seven:5, eight:6, over_nine:7 } #足のサイズの下一桁

end

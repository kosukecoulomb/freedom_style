class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum gender: { man:0, woman:1, other:2, do_not_answer:3 }
  enum generation: { teens:0, twenties:1, thirties:2, forties:3, over_fifties:4 }
  enum tall: { under_fifty:0, fifty:1, sixty:2, seventy:3, over_eighty:4 }
  enum body_shape: { slender:0, normal:1, fat:2, solid:3 }
  enum foot_size: { two:0, three:1, four:2, five:3, six:4, seven:5, eight:6, over_nine:7 }

end

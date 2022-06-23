FactoryBot.define do
  factory :user do
    name              { 'Taro' }
    email                 { Faker::Internet.free_email }
    password              { 'aaBB1234' }
    password_confirmation { password }
    gender            { 0 }
    generation        { 2 }
    tall              { 165 }
    body_shape        { 1 }
    foot_size         { 25 }

  end
end
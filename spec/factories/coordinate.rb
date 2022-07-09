FactoryBot.define do
  factory :coordinate do
    title { Faker::Lorem.characters(number: 10) }
    body { Faker::Lorem.characters(number: 30) }
    dress_code        { 0 }
    season            { 0 }
    temperature       { 0 }
    # coordinate_image     {Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/non-item.jpg'))}

    after(:build) do |coordinate|
      coordinate.coordinate_image.attach(io: File.open('app/assets/images/non-item.jpg'), filename: 'non-item.jpg', content_type: 'image/jpg')
    end

    association :user
  end
end

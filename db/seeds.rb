# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
   email: 'admin@test.com',
   password: 'aaaaaa'
)

User.create!(
[
{name: 'a子', email: 'a@test.com', password: 'password', introduction: 'よろしくお願いします！', gender: 1, generation: 2, tall: 157, body_shape: 0, foot_size: '24', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename: 'sample-user1.jpg')},
{name: 'b子', email: 'b@test.com', password: 'password', introduction: 'よろしくお願いします！', gender: 1, generation: 1, tall: 154, body_shape: 1, foot_size: '24', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename: 'sample-user2.jpg')},
{name: 'c子', email: 'c@test.com', password: 'password', introduction: 'よろしくお願いします！', gender: 2, generation: 1, tall: 160, body_shape: 0, foot_size: '24', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename: 'sample-user3.jpg')},
{name: 'd雄', email: 'd@test.com', password: 'password', introduction: 'よろしくお願いします！', gender: 0, generation: 2, tall: 170, body_shape: 3, foot_size: '24', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user4.jpg"), filename: 'sample-user4.jpg')},
{name: 'e美', email: 'e@test.com', password: 'password', introduction: 'よろしくお願いします！', gender: 1, generation: 1, tall: 155, body_shape: 0, foot_size: '24', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user5.jpg"), filename: 'sample-user5.jpg')},
{name: 'f美', email: 'f@test.com', password: 'password', introduction: 'よろしくお願いします！', gender: 2, generation: 1, tall: 152, body_shape: 0, foot_size: '24', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user6.jpg"), filename: 'sample-user6.jpg')},
{name: 'g奈', email: 'g@test.com', password: 'password', introduction: 'よろしくお願いします！', gender: 2, generation: 3, tall: 162, body_shape: 2, foot_size: '24', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user7.jpg"), filename: 'sample-user7.jpg')}
]
)

Coordinate.create!(
[
{user_id: 1, title: '夏の大人コーデ', body: '黒のレース柄ワンピースを使った大人コーデです！', dress_code: 1, season: 1, temperature: 4, coordinate_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-coordinate1.jpg"), filename: 'sample-coordinate1.jpg')},
{user_id: 1, title: '初夏のきれいめコーデ', body: 'ワンピースを使ったきれいめコーデです！', dress_code: 1, season: 1, temperature: 3, coordinate_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-coordinate2.jpg"), filename: 'sample-coordinate2.jpg')},
{user_id: 1, title: '白のワントーンコーデ', body: '白のワントーンにチャレンジしました！', dress_code: 1, season: 0, temperature: 2, coordinate_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-coordinate3.jpg"), filename: 'sample-coordinate3.jpg')},
{user_id: 2, title: 'さわやか春コーデ', body: '水色と白でさわやかなコーデを目指しました！', dress_code: 0, season: 0, temperature: 2, coordinate_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-coordinate4.jpg"), filename: 'sample-coordinate4.jpg')},
{user_id: 2, title: 'キャンパスコーデ', body: '紺と白のツートーンでまとめたコーデです！', dress_code: 0, season: 1, temperature: 1, coordinate_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-coordinate5.jpg"), filename: 'sample-coordinate5.jpg')},
{user_id: 3, title: '白のワントーンコーデ', body: '全身白系でまとめました。アウターは薄いベージュで統一感をもたせています', dress_code: 1, season: 3, temperature: 1, coordinate_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-coordinate6.jpg"), filename: 'sample-coordinate6.jpg')},
{user_id: 3, title: 'ジャケットコーデ', body: 'ジャケットを使ったジェンダーレスコーデです！', dress_code: 2, season: 2, temperature: 1, coordinate_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-coordinate7.jpg"), filename: 'sample-coordinate7.jpg')},
{user_id: 3, title: 'ジャケットコーデ2', body: 'この前上げたジャケットコーデのアレンジです！', dress_code: 2, season: 2, temperature: 1, coordinate_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-coordinate8.jpg"), filename: 'sample-coordinate8.jpg')},
{user_id: 4, title: 'ジャケットコーデ', body: '紺のジャケットは白シャツと合わせるだけで決まるのでおすすめです！', dress_code: 2, season: 1, temperature: 1, coordinate_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-coordinate9.jpg"), filename: 'sample-coordinate9.jpg')},
{user_id: 5, title: '白のワントーン', body: '全身白でまとめました！', dress_code: 1, season: 3, temperature: 1, coordinate_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-coordinate10.jpg"), filename: 'sample-coordinate10.jpg')},
{user_id: 6, title: '清涼感コーデ', body: '水色ベースで夏っぽさ全開です笑！', dress_code: 0, season: 2, temperature: 3, coordinate_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-coordinate11.jpg"), filename: 'sample-coordinate11.jpg')},
{user_id: 6, title: '白のロングベストコーデ', body: '紺のジャケットは白シャツと合わせるだけで決まるのでおすすめです！', dress_code: 2, season: 1, temperature: 1, coordinate_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-coordinate12.jpg"), filename: 'sample-coordinate12.jpg')},
{user_id: 7, title: 'カーディガンコーデ', body: '派手柄のワンピに白のカーディガンでバランス良く仕上げました', dress_code: 0, season: 1, temperature: 1, coordinate_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-coordinate13.jpg"), filename: 'sample-coordinate13.jpg')}

]
)

Item.create!(
[
{user_id: 2, category: 1, brand_name: 'BBB', item_name: 'ホワイトチェックシャツ', size: 'S', color: 'オフホワイト', price: 1200, item_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-item1.jpg"), filename: 'sample-item1.jpg')},
{user_id: 3, category: 4, brand_name: 'CCC', item_name: 'レザーボストンバッグ', size: 'なし', color: 'ブラック', price: 20000, item_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-item2.jpg"), filename: 'sample-item2.jpg')},
{user_id: 2, category: 0, brand_name: 'BBB', item_name: 'チェックトレンチコート', size: 'M', color: 'ブルー', price: 10800, item_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-item3.jpg"), filename: 'sample-item3.jpg')},
{user_id: 4, category: 3, brand_name: 'DDD', item_name: 'レザーシューズ', size: '27', color: 'セピア', price: 29000, item_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-item4.jpg"), filename: 'sample-item4.jpg')},
{user_id: 4, category: 1, brand_name: 'DDD', item_name: 'フランネルチェックシャツ', size: 'L', color: 'ピンク', price: 1200, item_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-item5.jpg"), filename: 'sample-item5.jpg')},
{user_id: 1, category: 2, brand_name: 'AAA', item_name: 'フラットジーンズ(写真下)', size: 'S', color: 'ブラックグレー', price: 3800, item_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-item6.jpg"), filename: 'sample-item6.jpg')},
{user_id: 1, category: 3, brand_name: 'AAA', item_name: 'キャンバススニーカー(写真上)', size: '24', color: 'レッド', price: 6500, item_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-item6.jpg"), filename: 'sample-item6.jpg')},
{user_id: 6, category: 4, brand_name: 'FFF', item_name: '麦わら帽子', size: 'なし', color: 'なし', price: 900, item_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-item7.jpg"), filename: 'sample-item7.jpg')},
{user_id: 5, category: 1, brand_name: 'EEE', item_name: 'メッシュシャツ', size: 'M', color: 'ブラック', price: 1500, item_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-item8.jpg"), filename: 'sample-item8.jpg')},
{user_id: 6, category: 2, brand_name: 'AAA', item_name: 'ウォッシャブルジーンズ', size: 'S', color: 'ブラックグレー', price: 3800, item_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-item9.jpg"), filename: 'sample-item9.jpg')},
{user_id: 4, category: 4, brand_name: 'DDD', item_name: '2WAYバッグ', size: 'なし', color: 'ブラックグレー', price: 3900, item_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-item10.jpg"), filename: 'sample-item10.jpg')},
{user_id: 5, category: 1, brand_name: 'EEE', item_name: 'クルーネックシャツ', size: 'S', color: 'ホワイト', price: 3800, item_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-item11.jpg"), filename: 'sample-item11.jpg')},
{user_id: 1, category: 2, brand_name: 'AAA', item_name: 'フラットジーンズ(写真下)', size: 'S', color: 'ブラックグレー', price: 3800, item_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-item9.jpg"), filename: 'sample-item9.jpg')},
{user_id: 7, category: 0, brand_name: 'GGG', item_name: 'レザーコート', size: 'L', color: 'レッド', price: 25000, item_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-item12.jpg"), filename: 'sample-item12.jpg')},
]
)
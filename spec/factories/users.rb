FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    encrypted_password { Devise.friendly_token }
    nickname { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    last_kananame { Faker::Name.last_name.yomi }
    first_kananame { Faker::Name.first_name.yomi }
    birthdate { Faker::Date.birthday(min_age: 18, max_age: 65) }
    # name属性を削除する
  end
end

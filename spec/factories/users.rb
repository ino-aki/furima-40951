require 'gimei'

FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    birthdate { Faker::Date.birthday }
    last_name { Gimei.last.kanji }
    first_name { Gimei.first.kanji }
    last_kananame { Gimei.last.katakana }
    first_kananame { Gimei.first.katakana }
  end
end

FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    category_id { Category.where.not(id: 1).pluck(:id).sample }
    itemcondition_id { Itemcondition.where.not(id: 1).pluck(:id).sample }
    shippingfee_id { Shippingfee.where.not(id: 1).pluck(:id).sample }
    prefecture_id { Prefecture.where.not(id: 1).pluck(:id).sample }
    shippingday_id { Shippingday.where.not(id: 1).pluck(:id).sample }
    price { Faker::Number.between(from: 300, to: 9999999) }

    user { association :user }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end

FactoryBot.define do
  factory :purchase_shippingaddress do
    postalcode { '123-4567' }
    prefecture_id { Prefecture.where.not(id: 1).pluck(:id).sample }
    city { Faker::Address.city }
    street_address { Faker::Address.street_address }
    building_name { Faker::Address.secondary_address }
    phone_number { Faker::Number.number(digits: rand(10..11)).to_s }
  end
end

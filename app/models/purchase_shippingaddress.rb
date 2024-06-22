class PurchaseShippingaddress
  include ActiveModel::Model

  attr_accessor :postalcode, :prefecture_id, :city, :street_address, :building_name, :phone_number, :user_id, :item_id,
                :token

  with_options presence: true do
    validates :token
    validates :postalcode, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :street_address
    validates :phone_number, length: { minimum: 10, maximum: 11, message: 'is too short' },
                             format: { with: /\A\d+\z/, message: 'is invalid. Input only number' }
    validates :user_id
    validates :item_id
  end

  def save
    purchase = Purchase.create(user_id:, item_id:)
    Shippingaddress.create(postalcode:, prefecture_id:, city:, street_address:,
                           building_name:, phone_number:, purchase_id: purchase.id)
  end
end

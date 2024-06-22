class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one :purchase

  has_one_attached :image
  belongs_to :category
  belongs_to :itemcondition
  belongs_to :shippingfee
  belongs_to :prefecture
  belongs_to :shippingday

  validates :image, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :itemcondition_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shippingfee_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shippingday_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end

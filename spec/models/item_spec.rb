require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '出品できる場合' do
      it '全ての情報が正しく入力されているとき、出品できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できない場合' do
      it '画像が添付されていない場合、出品できない（.image = nil）' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'nameが空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'descriptionが空では出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'category_idが1の場合、出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'itemcondition_idが1の場合、出品できない' do
        @item.itemcondition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Itemcondition can't be blank")
      end
      it 'shippingfee_idが1の場合、出品できない' do
        @item.shippingfee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shippingfee can't be blank")
      end
      it 'prefecture_idが1の場合、出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'shippingday_idが1の場合、出品できない' do
        @item.shippingday_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shippingday can't be blank")
      end
      it 'priceが空では出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが全角数字の場合、出品できない' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceが300未満の場合、出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it 'priceが9999999を超える場合、出品できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
      it 'userが紐付いていない場合、出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end

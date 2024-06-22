require 'rails_helper'

RSpec.describe PurchaseShippingaddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_shippingaddress = FactoryBot.build(:purchase_shippingaddress, user_id: user.id, item_id: item.id)
  end

  describe '購入情報の保存' do
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_shippingaddress).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @purchase_shippingaddress.building_name = ''
        expect(@purchase_shippingaddress).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postalcodeが空だと保存できないこと' do
        @purchase_shippingaddress.postalcode = ''
        @purchase_shippingaddress.valid?
        expect(@purchase_shippingaddress.errors.full_messages).to include("Postalcode can't be blank")
      end
      it 'postalcodeが「3桁ハイフン4桁」の形式でないと保存できないこと' do
        @purchase_shippingaddress.postalcode = '1234567'
        @purchase_shippingaddress.valid?
        expect(@purchase_shippingaddress.errors.full_messages).to include('Postalcode is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'prefecture_idが1だと保存できないこと' do
        @purchase_shippingaddress.prefecture_id = 1
        @purchase_shippingaddress.valid?
        expect(@purchase_shippingaddress.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できないこと' do
        @purchase_shippingaddress.city = ''
        @purchase_shippingaddress.valid?
        expect(@purchase_shippingaddress.errors.full_messages).to include("City can't be blank")
      end
      it 'street_addressが空だと保存できないこと' do
        @purchase_shippingaddress.street_address = ''
        @purchase_shippingaddress.valid?
        expect(@purchase_shippingaddress.errors.full_messages).to include("Street address can't be blank")
      end
      it 'phone_numberが空だと保存できないこと' do
        @purchase_shippingaddress.phone_number = ''
        @purchase_shippingaddress.valid?
        expect(@purchase_shippingaddress.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが10桁以上11桁以内の半角数値でないと保存できないこと' do
        @purchase_shippingaddress.phone_number = '090-1234-5678'
        @purchase_shippingaddress.valid?
        expect(@purchase_shippingaddress.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'userが紐付いていないと保存できないこと' do
        @purchase_shippingaddress.user_id = nil
        @purchase_shippingaddress.valid?
        expect(@purchase_shippingaddress.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @purchase_shippingaddress.item_id = nil
        @purchase_shippingaddress.valid?
        expect(@purchase_shippingaddress.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空では登録できないこと' do
        @purchase_shippingaddress.token = nil
        @purchase_shippingaddress.valid?
        expect(@purchase_shippingaddress.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end

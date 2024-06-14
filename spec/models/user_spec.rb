require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '正常に登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上であれば登録できる' do
        @user.password = 'test1234'
        @user.password_confirmation = 'test1234'
        expect(@user).to be_valid
      end
      it 'first_nameとlast_nameが全角であれば登録できる' do
        @user.first_name = '山田'
        @user.last_name = 'タロウ'
        expect(@user).to be_valid
      end
      it 'first_kananameとlast_kananameが全角であれば登録できる' do
        @user.first_kananame = 'アアアア'
        @user.last_kananame = 'イイイイ'
        expect(@user).to be_valid
      end
    end
    context '新規登録出来ない時' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordが数字だけだと登録できない' do
        @user.password = '11111111'
        @user.password_confirmation = '11111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end
      it 'passwordが英字だけだと登録できない' do
        @user.password = 'aaaaaaaa'
        @user.password_confirmation = 'aaaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end
      it 'passwordが全角だと登録できない' do
        @user.password = 'ああああああ'
        @user.password_confirmation = 'ああああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end
      it 'passwordとconfirmが一致していないと登録できない' do
        @user.password = 'test123'
        @user.password_confirmation = 'test1234'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordが英数字混合でも6文字未満なら登録できない' do
        @user.password = 'test1'
        @user.password_confirmation = 'test1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailには@が含まれていないと登録できない' do
        @user.email = 'aaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank",
                                                      'First name is invalid. Input full-width characters')
      end
      it 'first_nameが半角では登録できない' do
        @user.first_name = 'aaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters')
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank",
                                                      'Last name is invalid. Input full-width characters')
      end
      it 'last_nameが半角では登録できない' do
        @user.last_name = 'aaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters')
      end
      it 'first_kananameが空では登録できない' do
        @user.first_kananame = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First kananame can't be blank",
                                                      'First kananame is invalid. Input full-width katakana characters')
      end
      it 'first_kananameが半角では登録できない' do
        @user.first_kananame = 'aaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('First kananame is invalid. Input full-width katakana characters')
      end
      it 'last_kananameが空では登録できない' do
        @user.first_kananame = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First kananame can't be blank",
                                                      'First kananame is invalid. Input full-width katakana characters')
      end
      it 'last_kananameが半角では登録できない' do
        @user.first_kananame = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('First kananame is invalid. Input full-width katakana characters')
      end
      it 'birthdateが空では登録できない' do
        @user.birthdate = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthdate can't be blank")
      end
    end
  end
end

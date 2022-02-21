require 'rails_helper'

RSpec.describe OrderInfo, type: :model do
  describe '商品の購入' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_info = FactoryBot.build(:order_info, user_id: user.id, item_id: item.id)
      sleep(0.1)
    end

    context '購入できる場合' do
      it 'すべての値が正しく入力され、購入するユーザー情報、アイテム情報が存在すれが保存できる' do
        expect(@order_info).to be_valid
      end
      it 'building_nameは空でも保存できる' do
        building_name = ''
        expect(@order_info).to be_valid
      end
      it 'phone_numberは10桁でも保存できる' do
        phone_number = '0312345678'
        expect(@order_info).to be_valid
      end
    end
    context '購入できない場合' do
      it 'prefectureを選択しないと登録できない(prefecture_idが1では登録できない)' do
        @order_info.prefecture_id = '1'
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'post_codeが空では登録できない' do
        @order_info.post_code = ''
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include("Post code can't be blank")
      end
      it 'post_codeは全角では登録できない' do
        @order_info.post_code = '１２３−４５６７'
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it 'post_codeはハイフン(-)無しでは登録できない' do
        @order_info.post_code = '1234567'
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it 'post_codeはハイフン(-)の前が3桁以外では登録できない' do
        @order_info.post_code = '1234-567'
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it 'post_codeはハイフン(-)の後が4桁以外では登録できない' do
        @order_info.post_code = '123-456'
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it 'cityが空では登録できない' do
        @order_info.city = ''
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが空では登録できない' do
        @order_info.address = ''
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberが空では登録できない' do
        @order_info.phone_number = ''
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが数字以外を含むと登録できない' do
        @order_info.phone_number = '080-1234-5678'
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include('Phone number is invalid. Input half-width 10 to 11 digits numbers')
      end
      it 'phone_numberが全角では登録できない' do
        @order_info.phone_number = '０８０１２３４５６７８'
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include('Phone number is invalid. Input half-width 10 to 11 digits numbers')
      end
      it 'phone_numberが10~11桁以外では登録できない' do
        @order_info.phone_number = '080123456789'
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include('Phone number is invalid. Input half-width 10 to 11 digits numbers')
      end
      it 'tokenが空では登録できない' do
        @order_info.token = ''
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include("Token can't be blank")
      end
      it 'ユーザーが紐付いていないと登録できない' do
        @order_info.user_id = nil
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと登録できない' do
        @order_info.item_id = nil
        @order_info.valid?
        expect(@order_info.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end

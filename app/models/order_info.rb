class OrderInfo
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :city, :address, :building_name, :phone_number, :prefecture_id, :token

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, allow_blank: true, message: 'はハイフン(-)を含む半角数字で入力してください' }
    validates :city
    validates :address
    validates :phone_number,
              format: { with: /\A[0-9]{10,11}\z/, allow_blank: true,
                        message: 'はハイフン(-)無し半角数字10~11桁で入力してください' }
    validates :token, presence: { message: 'を正しく入力してください' }
  end

  validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    ShippingAddress.create(post_code: post_code, city: city, address: address, building_name: building_name,
                           phone_number: phone_number, prefecture_id: prefecture_id, order_id: order.id)
  end
end

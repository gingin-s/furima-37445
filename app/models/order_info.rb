class OrderInfo
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :city, :address, :building_name, :phone_number, :prefecture_id, :token

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, allow_blank: true, message: 'is invalid. Include hyphen(-)' }
    validates :city
    validates :address
    validates :phone_number,
              format: { with: /\A[0-9]{10,11}\z/, allow_blank: true,
                        message: 'is invalid. Input half-width 10 to 11 digits numbers' }
    validates :token
  end

  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    ShippingAddress.create(post_code: post_code, city: city, address: address, building_name: building_name,
                           phone_number: phone_number, prefecture_id: prefecture_id, order_id: order.id)
  end
end

class ShippingAddress < ApplicationRecord

  belongs_to :order
  belongs_to_active_hash :prefecture

  with_options presence: true do
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, allow_blank: true, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :adress
    validates :phone_number, format: {with: /\A[0-9]{10.11}\z/, message: "is invalid. Input half-width 10 to 11 digits numbers."}
  end

  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }


end

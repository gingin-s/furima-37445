class ShippingAddress < ApplicationRecord

  belongs_to :order
  belongs_to_active_hash :prefecture
end

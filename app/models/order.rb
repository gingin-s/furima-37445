class Order < ApplicationRecord

  has_one :shipping_address

  belongs_to :item
  belongs_to :user
end

class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :Shipping_date

  belongs_to :user

  with_options presence: true do
  validates :title
  validates :description
  validates :price, nemericality: { in: 300..9999999, allow_blank: true }
  end

  with_options numericality: { other_than: 1, message: "can't be blank"}
end

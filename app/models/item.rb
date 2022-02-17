class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :Shipping_date

  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :title
    validates :description
    validates :image
    validates :price, nemericality: { in: 300..9999999, allow_blank: true }
  end

  with_options numericality: { other_than: 1, message: "can't be blank"} do
    validates :category_id
    validates :condition_id
    validates :postage_id
    validates :prefecture_id
    validates :shipping_date_id
  end
end

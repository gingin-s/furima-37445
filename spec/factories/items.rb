FactoryBot.define do
  factory :item do
    title { '商品タイトル' }
    description { '商品の説明' }
    price { Faker::Number.within(range: 300..9999999) }
    category_id { Category.find_by(name: "メンズ").id }
    condition_id { Condition.find_by(name: "やや傷あり").id }
    postage_id { Postage.find_by(name: "送料込み(出品者負担)").id }
    prefecture_id { Prefecture.find_by(name: "東京都").id }
    shipping_on_id { ShippingOn.find_by(name: "4~7日で発送").id }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end

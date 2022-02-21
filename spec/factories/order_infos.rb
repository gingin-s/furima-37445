FactoryBot.define do
  factory :order_info do
    post_code { '123-4567' }
    city { 'hoge区huga町' }
    address { '1-1' }
    building_name { 'メゾン・ド・Huga' }
    phone_number { '08012345678' }
    prefecture_id { Prefecture.find_by(name: '東京都').id }

    token {"tok_abcdefghijk00000000000000000"}
  end
end

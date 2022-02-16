# テーブル設計

## users table

| Column                | Type           | Options                     |
|-----------------------|----------------|-----------------------------|
| email                 | string         | null: false, unique: true   |
| encrypted_password    | string         | null: false                 |
| nickname              | string         | null: false                 |
| first_name            | string         | null: false                 |
| last_name             | string         | null: false                 |
| first_name_kana       | string         | null: false                 |
| last_name_kana        | string         | null: false                 |
| birthday              | date           | null: false                 |



### Association

- has_many :items
- has_many :orders

## itemsテーブル

| Column                | Type           | Options                        |
|-----------------------|----------------|--------------------------------|
| title                 | string         | null: false                    |
| description           | text           | null: false                    |
| price                 | integer        | null: false                    |
| category_id           | integer        | null: false                    |
| condition_id          | integer        | null: false                    |
| postage_id            | integer        | null: false                    |
| prefecture_id         | integer        | null: false                    |
| shipping_date_id      | integer        | null: false                    |
| user                  | references     | null: false, foreign_key: true |

### Association

- has_one :order
- belongs_to :user

## ordersテーブル

| Column                | Type           | Options                        |
|-----------------------|----------------|--------------------------------|
| item                  | references     | null: false, foreign_key: true |
| user                  | references     | null: false, foreign_key: true |

### Association

- has_one :ship_address
- belongs_to :item
- belongs_to :user

## ship_addressesテーブル

| Column                | Type           | Options                        |
|-----------------------|----------------|--------------------------------|
| post_code             | string         | null: false                    |
| city                  | string         | null: false                    |
| address               | string         | null: false                    |
| building_name         | string         |                                |
| phon_number           | string         | null: false                    |
| prefecture_id         | integer        | null: false                    |
| order                 | references     | null: false, foreign_key: true |

### Association

- belongs_to :order
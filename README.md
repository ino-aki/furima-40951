# テーブル設計

## users テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| nickname           | string  | null: false |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false |
| fullname           | string  | null: false |
| kananame           | string  | null: false |
| birthdate_id       | integer | null: false, foreign_key: true |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column            | Type       | Options     |
| ----------------- | ---------- | ----------- |
| image             | string     | null: false |
| name              | string     | null: false |
| description       | text       | null: false |
| category_id       | integer    | null: false, foreign_key: true |
| itemcondition_id  | integer    | null: false, foreign_key: true |
| shippingfee_id    | integer    | null: false, foreign_key: true |
| shippingregion_id | integer    | null: false, foreign_key: true |
| shippingdays_id   | integer    | null: false, foreign_key: true |
| price             | integer    | null: false |
| user_id           | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase

## purchases テーブル

| Column  | Type       | Options     |
| ------- | ---------- | ----------- |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :purchase
- has_one :shippingaddress

## shippingaddresses テーブル

| Column         | Type       | Options     |
| -------------- | ---------- | ----------- |
| postalcode     | string     | null: false |
| prefecture_id  | integer    | null: false, foreign_key: true |
| city           | string     | null: false |
| street_address | string     | null: false |
| building_name  | string     | null: false |
| phone_number   | string     | null: false |
| purchase_id    | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase
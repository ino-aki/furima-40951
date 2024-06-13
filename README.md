# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_kananame      | string | null: false |
| first_kananame     | string | null: false |
| birthdate          | date   | null: false |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column           | Type       | Options     |
| ---------------- | ---------- | ----------- |
| name             | string     | null: false |
| description      | text       | null: false |
| category_id      | integer    | null: false |
| itemcondition_id | integer    | null: false |
| shippingfee_id   | integer    | null: false |
| prefecture_id    | integer    | null: false |
| shippingday_id   | integer    | null: false |
| price            | integer    | null: false |
| user             | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase

## purchases テーブル

| Column | Type       | Options     |
| ------ | ---------- | ----------- |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shippingaddress

## shippingaddresses テーブル

| Column         | Type       | Options     |
| -------------- | ---------- | ----------- |
| postalcode     | string     | null: false |
| prefecture_id  | integer    | null: false |
| city           | string     | null: false |
| street_address | string     | null: false |
| building_name  | string     |
| phone_number   | string     | null: false |
| purchase       | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase
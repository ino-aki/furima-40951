# テーブル設計

## users テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| nickname           | string  | null: false |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false |
| fullname           | string  | null: false |
| kananame           | string  | null: false |
| birthday           | date    | null: false |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column         | Type       | Options     |
| -------------- | ---------- | ----------- |
| image          | string     | null: false |
| name           | string     | null: false |
| description    | text       | null: false |
| category       | integer    | null: false |
| condition      | integer    | null: false |
| shippingcost   | integer    | null: false |
| shippingdays   | integer    | null: false |
| shippingregion | integer    | null: false |
| price          | integer    | null: false |
| user           | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase

## purchases テーブル

| Column    | Type       | Options     |
| --------- | ---------- | ----------- |
| user_id   | references | null: false, foreign_key: true |
| item_id   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shippingaddress

## shippingaddresses テーブル

| Column        | Type       | Options     |
| ------------- | ---------- | ----------- |
| postalcode    | string     | null: false |
| prefecture    | integer    | null: false |
| city          | string     | null: false |
| streetAddress | string     | null: false |
| buildingName  | string     | null: false |
| phoneNumber   | string     | null: false |
| purchase_id  | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase
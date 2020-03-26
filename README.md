# README
## アプリケーション概要
TECH:CAMP最終課題フリマアプリです。３人のチームでアジャイル開発を行いました。
[![Image from Gyazo](https://i.gyazo.com/0d7b08888383510541e0228df6334ffd.jpg)](https://gyazo.com/0d7b08888383510541e0228df6334ffd)

## 機能一覧
●ユーザー登録、ログイン機能(ウィザード形式)

●商品出品機能

●商品購入機能

●クレジットカード登録機能(PayJP)

#使用技術
###■言語
バックエンド
Ruby 2.5.1

フロントエンド
jquery-rails 4.3.5

###◼︎フレームワーク
Ruby on Rails 5.2.4.1

###◼︎データベース
MySQL 0.5.3

###◼︎インフラ
AWS EC2

AWS S3

###デプロイ
Capistranoによる自動デプロイ

# DB設計
## usersテーブル

|Column|Type|Options|
|------|----|-------|
| nickname | string | null: false|
| email | string | null: false, unique: true |
| password | string | null: false |

### Association
- has_many :items
- has_one :user_detail, dependent: :destroy
- has_one :credit_card, dependent: :destroy


## user_detailsテーブル

|Column|Type|Options|
|------|----|-------|
| first_name | string | null: false |
| first_name_kana | string | null: false |
| last_name | string | null: false |
| last_name_kana | string | null: false |
| birthday | date | null: false |
| destination_name | string | null: false |
| destination_kana | string | null: false |
| post_code | integer | null: false |
| prefectures | integer | null: false |
| mayor | string | null: false |
| address | string | null: false |
| building | text |  |
| phone_no | string |  |
| user_id |references|null: false, foreign_key: true|

### Association
- belongs_to :user


## credit_cardテーブル

|Column|Type|Options|
|------|----|-------|
| user_id |references|null: false, foreign_key: true|
| customer_id | string | null: false |
| card_id | string | null: false |

### Association
- belongs_to :user


## itemsテーブル

|Column|Type|Options|
|------|----|-------|
| name | string | null: false, add_index |
| description | text | null: false |
| status_id | integer | null: false |
| fee_side_id | integer | null: false |
| prefectures_id | integer | null: false |
| shipping_days_id | integer | null: false |
| price | integer | null: false |
| user_id |references|null: false, foreign_key: true|
| buyer_id | references|foreign_key: true|
| category_id |references|null: false, foreign_key: true|
| size_id | integer |  |
| brand_id |references|foreign_key: true|

### Association
- belongs_to :user
- has_many :images
- belongs_to :category
- belongs_to :brand
- accepts_nested_attributes_for :images, allow_destroy: true
- accepts_nested_attributes_for :brand
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :fee_side
- belongs_to_active_hash :shipping_days
- belongs_to_active_hash :size
- belongs_to_active_hash :status



## imagesテーブル

|Column|Type|Options|
|------|----|-------|
| image | string | null: false |
| item_id |references|null: false, foreign_key: true|

### Association
- belongs_to :item


## categoriesテーブル

|Column|Type|Options|
|------|----|-------|
| name | string | null: false |
| ancestry | string ||

### Association
- has_many :items


## brandsテーブル

|Column|Type|Options|
|------|----|-------|
| name | string | null: false |

### Association
- has_many :items

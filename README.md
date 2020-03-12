# README

## usersテーブル

|Column|Type|Options|
|------|----|-------|
| nickname | string | null: false|
| email | string | null: false, unique: true |
| password | string | null: false |

### Association
- has_many :items, dependent: :destroy
- has_one :user_detail, dependent: :destroy
- has_one :payment, dependent: :destroy


## user_detailsテーブル

|Column|Type|Options|
|------|----|-------|
| name | string | null: false |
| name_kana | string | null: false |
| birthday | integer | null: false |
| destination_name | string | null: false |
| destination_kana | string | null: false |
| post_code | integer | null: false |
| prefectures | string | null: false |
| mayor | string | null: false |
| address | string | null: false |
| building | text |  |
| phone_no | integer |  |
| user_id |references|null: false, foreign_key: true|

### Association
- belongs_to :user


## paymentsテーブル

|Column|Type|Options|
|------|----|-------|
| card_number | integer | null: false, unique:true |
| exp_month | date | null: false |
| exp_year | date | null: false |
| security_cord | integer | null: false |
| user_id |references|null: false, foreign_key: true|

### Association
- belongs_to :user


## itemsテーブル

|Column|Type|Options|
|------|----|-------|
| name | string | null: false, add_index |
| description | text | null: false |
| status | string | null: false |
| fee_side | string | null: false |
| prefectures | string | null: false |
| shipping_days | string | null: false |
| price | integer | null: false |
| saler_id |references|null: false, foreign_key: true|
| buyer_id | references|foreign_key: true|
| user_id |references|null: false, foreign_key: true|
| category_id |references|null: false, foreign_key: true|
| size | string |  |
| brand_id |references|foreign_key: true|

### Association
- belongs_to :user
- has_many :images
- belongs_to :category
- belongs_to :brand


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
| ancestry | integer ||

### Association
- has_many :items


## brandsテーブル

|Column|Type|Options|
|------|----|-------|
| name | string ||

### Association
- has_many :items




test
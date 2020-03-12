class Item < ApplicationRecord
  has_many :images, dependent: :destroy
  # belongs_to :user
  belongs_to :category, optional: true
  belongs_to :brand, optional: true
  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :brand
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :fee_side
  belongs_to_active_hash :shipping_day
  belongs_to_active_hash :size
  belongs_to_active_hash :status

  validates :images, presence: true, length: {manimum: 1, maximum: 10}
  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :status_id, presence: true
  validates :fee_side_id, presence: true
  validates :shipping_days_id, presence: true
  validates :prefecture_id, presence: true
  validates :price, presence: true, inclusion: 300..9999999
  validates :buyer_id, presence: true
  validates :category_id, presence: true

end

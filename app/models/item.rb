class Item < ApplicationRecord
  # has_many :images, dependent: :destroy
  belongs_to :category
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :fee_side
  belongs_to_active_hash :shipping_day
  belongs_to_active_hash :size
  belongs_to_active_hash :status
  # accepts_nested_attributes_for :images, allow_destroy: true
end

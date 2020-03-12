class Image < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :item, optional: true
  validates :item, presence: true
  validates :image, presence: true
end

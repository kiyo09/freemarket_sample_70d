class Category < ApplicationRecord
  has_many :items
  has_ancestry
  accepts_nested_attributes_for :items
end

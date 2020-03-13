class UserDetail < ApplicationRecord
  belongs_to :user, optional: true


  validates :first_name,      presence: true
  validates :first_name_kana, presence: true
  validates :last_name,       presence: true
  validates :last_name_kana,  presence: true
  validates :birthday,        presence: true
  validates :desination_name, presence: true
  validates :desination_kana, presence: true
  validates :post_code,       presence: true
  validates :prefectures,     presence: true
  validates :mayor,           presence: true
  validates :address,         presence: true


end

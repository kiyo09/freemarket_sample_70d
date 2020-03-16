class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :items
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :credit_card, dependent: :destroy
  has_one :user_detail, dependent: :destroy

  validates :nickname, presence: true
end

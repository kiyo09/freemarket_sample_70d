class UserDetail < ApplicationRecord
  belongs_to :user, optional: true
end

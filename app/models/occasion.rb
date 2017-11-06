class Occasion < ApplicationRecord

  has_many :occasions_users
  has_many :users, through: :occasions_users

end

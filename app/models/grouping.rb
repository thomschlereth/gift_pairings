class Grouping < ApplicationRecord

  has_many :groupings_users
  has_many :users, through: :groupings_users

end

class Grouping < ApplicationRecord

  validates_uniqueness_of :name

  has_many :groupings_users
  has_many :users, through: :groupings_users

end

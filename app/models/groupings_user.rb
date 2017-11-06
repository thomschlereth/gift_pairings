class GroupingsUser < ApplicationRecord

  has_many :groupings
  has_many :users

end

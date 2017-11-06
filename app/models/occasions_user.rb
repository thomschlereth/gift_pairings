class OccasionsUser < ApplicationRecord

  has_many :occasions
  has_many :users

end

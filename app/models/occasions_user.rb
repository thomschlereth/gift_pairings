class OccasionsUser < ApplicationRecord

  belongs_to :occasion
  belongs_to :user

end

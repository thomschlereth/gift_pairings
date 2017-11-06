class OccasionsUser < ApplicationRecord

  belongs_to :occasion
  belongs_to :user
  belongs_to :grouping

  belongs_to :giver, class_name: 'OccasionsUser', foreign_key: 'giver_id', required: false
  belongs_to :reciever, class_name: 'OccasionsUser', foreign_key: 'reciever_id', required: false

end

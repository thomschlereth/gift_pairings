class User < ApplicationRecord

  belongs_to :giver, class_name: 'User', foreign_key: 'giver_id', required: false
  belongs_to :reciever, class_name: 'User', foreign_key: 'reciver_id', required: false

  has_many :groupings_users
  has_many :groupings, through: :groupings_users
  has_many :occasions_users
  has_many :occasions, through: :occasions_users


end

class User < ApplicationRecord

  has_secure_password

  belongs_to :giver, class_name: 'User', foreign_key: 'giver_id', required: false
  belongs_to :reciever, class_name: 'User', foreign_key: 'reciever_id', required: false

  has_many :groupings_users
  has_many :groupings, through: :groupings_users
  has_many :occasions_users
  has_many :occasions, through: :occasions_users

  validates_presence_of :first_name, :last_name, :username, :password_digest
  validates_uniqueness_of :username

end

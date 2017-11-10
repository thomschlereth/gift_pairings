class User < ApplicationRecord

  has_secure_password

  belongs_to :grouping, required: false

  has_many :occasions_users
  has_many :occasions, through: :occasions_users
  has_many :givers, through: :occasions_users
  has_many :recievers, through: :occasions_users

  validates_presence_of :first_name, :last_name, :username, :password_digest
  validates_uniqueness_of :username

end

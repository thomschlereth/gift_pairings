class Occasion < ApplicationRecord

  has_many :occasions_users
  has_many :users, through: :occasions_users

  def happy_guests?
    occasions_users.where({reciever: nil, giver: nil }).length < 1
  end

end

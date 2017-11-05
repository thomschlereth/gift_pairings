class User < ApplicationRecord

  belongs_to :giver, class_name: 'User', foreign_key: 'giver_id'
  belongs_to :reciever, class_name: 'User', foreign_key: 'reciver_id'

end

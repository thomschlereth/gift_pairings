class User < ApplicationRecord

  belongs_to :giver, class_name: 'User', foreign_key: 'giver_id', required: false
  belongs_to :reciever, class_name: 'User', foreign_key: 'reciver_id', required: false

end

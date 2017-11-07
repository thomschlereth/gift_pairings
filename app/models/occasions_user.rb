class OccasionsUser < ApplicationRecord

  belongs_to :occasion
  belongs_to :user

  belongs_to :giver, class_name: 'OccasionsUser', foreign_key: 'giver_id', required: false
  belongs_to :reciever, class_name: 'OccasionsUser', foreign_key: 'reciever_id', required: false

  def self.check_recievers(occasion)
    occasion.occasions_users.map do |user|
      "#{user.user.first_name} #{user.user.last_name} gives to #{user.reciever.user.first_name} #{user.reciever.user.last_name}" if user.reciever
    end
  end

  def self.check_givers(occasion)
    occasion.occasions_users.map do |user|
      "#{user.user.first_name} #{user.user.last_name} recieves from #{user.giver.user.first_name} #{user.giver.user.last_name}" if user.giver
    end
  end

end

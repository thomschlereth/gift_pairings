class User < ApplicationRecord

  has_secure_password

  belongs_to :grouping, required: false

  has_many :occasions_users
  has_many :occasions, through: :occasions_users
  has_many :givers, through: :occasions_users
  has_many :recievers, through: :occasions_users

  validates_presence_of :first_name, :last_name, :username, :password_digest
  validates_uniqueness_of :username


  def self.create_pairings(occasion)
    event_users = occasion.occasions_users
    event_users.each do |giver|
      create_match(giver,event_users)
    end
    unhappy_guests = event_users.where({reciever: nil, giver: nil })
    if unhappy_guests.length > 0
      occasion.occasions_users.update(reciever: nil, giver: nil)
      create_pairings(occasion)
    end
  end

  private

    def self.create_match(giver,event_users)
      reciever = event_users.shuffle.find do |reciever|
        no_grouping?(giver) || no_grouping?(reciever) || groups_dont_match?(giver,reciever) && hasnt_recieved?(event_users, reciever)
      end
      return false if !reciever
      giver.update(reciever: reciever)
      reciever.update(giver: giver)
    end

    def self.no_grouping?(event_user)
      !event_user.user.grouping
    end

    def self.groups_dont_match?(giver,reciever)
      giver.user.grouping != reciever.user.grouping
    end

    def self.hasnt_recieved?(event_users, reciever)
      event_users.where(reciever_id: reciever.id).length < 1
    end

end

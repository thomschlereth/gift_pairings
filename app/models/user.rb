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
  end

  def self.check_recievers
    User.all.map do |user|
      "#{user.first_name} #{user.last_name} gives to #{user.reciever.first_name} #{user.reciever.last_name}"
    end
  end

  def self.check_givers
    User.all.map do |user|
      "#{user.first_name} #{user.last_name} recieves from #{user.giver.first_name} #{user.giver.last_name}"
    end
  end

  private

    def self.create_match(giver,event_users)
      reciever = event_users.shuffle.find do |reciever|
        no_grouping?(giver) || no_grouping?(reciever) || groups_dont_match(giver,reciever)
      end
      return false if !reciever
      giver.update(reciever: reciever)
      reciever.update(giver: giver)
    end

    def no_grouping?(event_user)
      !event_user.user.grouping
    end

    def groups_dont_match(giver,reciever)
      giver.user.grouping != reciever.user.grouping
    end

end

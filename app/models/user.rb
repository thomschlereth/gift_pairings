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


  def self.create_pairings
    all.each do |user|
      create_match(user)
    end
  end

  def self.check_recievers
    User.all.map do |user|
      # binding.pry
      "#{user.first_name} #{user.last_name} gives to #{user.reciever.first_name} #{user.reciever.last_name}"
    end
  end

  def self.check_givers
    User.all.map do |user|
      "#{user.first_name} #{user.last_name} recieves from #{user.giver.first_name} #{user.giver.last_name}"
    end
  end

  private

    def self.create_match(user)
      matched = all.shuffle.find do |match|
        binding.pry
        user.groupings.first != match.groupings.first && !match.giver
      end
      return false if !matched
      user.update(reciever: matched).save
      matched.update(giver: user).save
    end

end

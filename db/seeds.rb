# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

module Seed

  def self.run(occasion, users, groupings)
    party = Party.new(occasion, users, groupings)
    create_groupings_users(party.groupings_out, party.users_out)
    create_occasions_users(party.occasion_out, party.users_out)
  end

  def self.create_groupings_users(groupings, users)

    groupings.each do |grouping|
      users.each do |user|
        if user.last_name == grouping.name
          GroupingsUser.create(grouping_id: grouping.id, user_id: user.id)
        end
      end
    end

  end

  def self.create_occasions_users(occasion, users)
    users.each do |user|
      OccasionsUser.create(occasion_id: occasion.id, user_id: user.id)
    end
  end

  class Party
    attr_reader :occasion_out, :users_out, :groupings_out

    def initialize(occasion_in, users_in, groupings_in)
      @occasion_out = nil
      @users_out = []
      @groupings_out = []
      create_occasion(occasion_in)
      create_users(users_in)
      create_groupings(groupings_in)
    end

    def create_occasion(occasion)
      @occasion_out = Occasion.create(occasion)
    end

    def create_users(users)
      users.each do |user|
        @users_out << User.create(user)
      end
    end

    def create_groupings(groupings)
      groupings.each do |grouping|
        @groupings_out << Grouping.create(grouping)
      end
    end

  end

end

occasion = { title: "Christmas Pickett's Siblings", year: '2017' }
users = [
  { first_name: "Thom", last_name: "Schlereth", username: "thom_schlereth", password: 'password' },
  { first_name: "Ali", last_name: "Schlereth", username: "ali_schlereth", password: 'password' },
  { first_name: "Jess", last_name: "Hargett", username: "jess_hargett", password: 'password' },
  { first_name: "Bryan", last_name: "Hargett", username: "bryan_hargett", password: 'password' },
  { first_name: "Bryan", last_name: "Howell", username: "bryan_howell", password: 'password' },
  { first_name: "Amanda", last_name: "Howell", username: "amanda_howell", password: 'password' },
  { first_name: "Lee", last_name: "Pickett", username: "lee_pickett", password: 'password' },
  { first_name: "Nicole", last_name: "Pickett", username: "nicole_pickett", password: 'password' }
]
groupings = [
  { name: "Hargett Couple" },
  { name: "Pickett Couple" },
  { name: "Howell Couple" },
  { name: "Schlereth Couple" }
]
Seed.run(occasion,users,groupings)

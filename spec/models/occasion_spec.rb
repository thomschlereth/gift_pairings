require 'rails_helper'

RSpec.describe Occasion, type: :model do

  it "can create all matches consistently with even numbers" do
    200.times do |i|
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
        { name: "Hargett" },
        { name: "Pickett" },
        { name: "Howell" },
        { name: "Schlereth" }
      ]
      Seed.run(occasion,users,groupings)

      occasion = Occasion.first
      occasion.create_pairings

      giver_ids = []
      reciever_ids = []
      occasion.occasions_users.each do |oc|
        giver_ids << oc.giver.id
        reciever_ids << oc.reciever.id
        expect(oc.giver).to be_truthy
        expect(oc.reciever).to be_truthy
      end
      expect(giver_ids.uniq.size).to eq(giver_ids.size)
      expect(reciever_ids.uniq.size).to eq(reciever_ids.size)
      puts "ok loop number #{i + 1}"
      OccasionsUser.delete_all
      Occasion.delete_all
      User.delete_all
      Grouping.delete_all
    end

  end

end

module Seed

  def self.run(occasion, users, groupings)
    party = Party.new(occasion, users, groupings)
    create_groupings_users(party.groupings_out, party.users_out)
    create_occasions_users(party.occasion_out, party.users_out)
  end

  def self.create_groupings_users(groupings, users)

    users.each do |user|
      grouping = groupings.find do |grouping|
        grouping.name == user.last_name
      end
      user.update(grouping: grouping)
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

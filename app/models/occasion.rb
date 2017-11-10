class Occasion < ApplicationRecord

  has_many :occasions_users
  has_many :users, through: :occasions_users

  def happy_guests?
    occasions_users.where(reciever: nil).size < 1 && occasions_users.where(giver: nil).size < 1
  end

  def create_pairings
    taco = false
    until taco == true do
      occasions_users.each do |giver|
        create_match(giver,occasions_users)
      end
      if happy_guests?
        taco = true
      else
        occasions_users.update(reciever: nil, giver: nil)
      end
    end
  end

  private

    def create_match(giver,event_users)
      reciever = event_users.shuffle.find do |reciever|
        no_grouping?(giver) || no_grouping?(reciever) || groups_dont_match?(giver,reciever) && hasnt_recieved?(event_users, reciever)
      end
      return false if !reciever
      giver.update(reciever: reciever)
      reciever.update(giver: giver)
    end

    def no_grouping?(event_user)
      !event_user.user.grouping
    end

    def groups_dont_match?(giver,reciever)
      giver.user.grouping != reciever.user.grouping
    end

    def hasnt_recieved?(event_users, reciever)
      event_users.where(reciever_id: reciever.id).length < 1
    end

end

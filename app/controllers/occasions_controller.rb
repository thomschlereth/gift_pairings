class OccasionsController < ApplicationController

  def index
    if current_user
      @occasions = current_user.occasions
    end
  end

  def show
    @occasion = Occasion.find(params[:id])
    if @occasion && current_user && current_user.occasions.find_by_id(@occasion.id)
      current_occasions_user = @occasion.occasions_users.joins(:user).where( { users: { username: current_user.username} }).first
      @reciever = current_occasions_user.reciever
    end
  end

  def generate
    occasion = Occasion.find(params[:id])
    occasion.create_pairings
    redirect_to occasion_path(occasion)
  end

end

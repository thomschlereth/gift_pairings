class UsersController < ApplicationController

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def index
    occasion = Occasion.first
    User.create_pairings(occasion)
  end

  def update
    current_user.update(users_params)
    redirect_to user_path(current_user)
  end

  private

    def users_params
      params.require(:user).permit(:password, :username)
    end

end

class UsersController < ApplicationController

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def index
    @users = User.all
    User.create_pairings
    @receivers = User.check_recievers
    @givers    = User.check_givers

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

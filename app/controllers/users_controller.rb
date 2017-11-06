class UsersController < ApplicationController

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def index
    @users = User.all
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

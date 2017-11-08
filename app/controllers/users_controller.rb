class UsersController < ApplicationController

  def show
  end

  def edit
    @user = current_user
  end

  def update
    current_user.update(users_params)
    flash[:success] = "Wokka Wokka"
    redirect_to user_path(current_user)
  end

  private

    def users_params
      params.require(:user).permit(:password, :username)
    end

end

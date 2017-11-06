class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
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

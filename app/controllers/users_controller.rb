class UsersController < ApplicationController

  def show
  end

  def edit
    @user = User.find(params[:id]) || current_user
    session[:user_id] = @user.id
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

class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      check_login_toggle_and_redirect
    else
      flash[:danger] = "That was an incorrect username, or password......or both, it's probably both. Lets try again, correctly this time."
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to("/")
  end

  private

    def check_login_toggle_and_redirect
      if params[:password] == "password"
        flash[:warning] = "Since this is your first visit, please update your password before continuing."
        redirect_to edit_user_path(current_user)
      else
        flash[:success] = "Wokka Wokka"
        redirect_to user_path(current_user)
      end
    end
end

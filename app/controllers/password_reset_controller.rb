class PasswordResetController < ApplicationController

  def  new
  end

  def create
    @user = User.find_by(email: password_reset_params[:email])
    if @user
      UserResetPasswordMailer.send_password_reset_email(@user).deliver
      flash[:success] = 'Password reset link sent'
      redirect_to('/')
    else
      flash[:failure] = "We can't find a user with that email address, please try again"
      render action: 'new'
    end
  end

  private

    def password_reset_params
      params.permit(:email)
    end

end

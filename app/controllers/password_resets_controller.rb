class PasswordResetsController < ApplicationController

  def create
    user = User.find_by_email(params[:email])
    if user
      UserMailer.password_reset(user).deliver
      redirect_to confirm_password_reset_path	
    else
	    flash[:error] = params[:email].blank? ? "Email cannot be blank, please try again."
	    : "Invalid email address please try again"
	    redirect_to password_reset_path
    end
  end
end
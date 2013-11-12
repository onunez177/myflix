class PasswordResetsController < ApplicationController

  def create
    user = User.find_by_email(params[:email])
    if user
      UserMailer.password_reset(user).deliver
      redirect_to confirm_password_reset_path	
    else
	    flash[:error] = params[:email].blank? ? "Email cannot be blank, please try again."
	    : "Invalid email address please try again"
	    redirect_to new_password_reset_path
    end
  end

  def edit
    @user = User.find_by_token!(params[:id]) # using ! format to generate a 404 error if user not found
  end

  def update
  end
end
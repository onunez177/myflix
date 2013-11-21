class PasswordResetsController < ApplicationController

  def create
    user = User.find_by_email(params[:email])
    if user
      UserMailer.delay.password_reset(user)
      redirect_to confirm_password_reset_path	
    else
	    flash[:error] = params[:email].blank? ? "Email cannot be blank, please try again."
	    : "Invalid email address please try again"
	    redirect_to new_password_reset_path
    end
  end

  def edit
    @user = User.find_by_token(params[:id]) 
    if @user 
      render :edit 
    else
      flash[:error] = "Sorry, but that link has expired."
      redirect_to new_password_reset_path
    end
  end

  def update
    @user = User.find_by_token(params[:id])
    @user.password = params[:password]
       
    if @user.password.blank? || @user.password.length < 5 # need to check if the password is valid first!
      flash[:error] = "Password too short, must be minimum 5 characters." # password being too short is the only possible fail state here
      render :edit       
    else
      flash[:notice] = "Successfully updated password. Thank you, #{@user.full_name}."
      @user.generate_token # generate a new token for user
      @user.save # and save the new password/token info
      redirect_to login_path
    end
  end
end
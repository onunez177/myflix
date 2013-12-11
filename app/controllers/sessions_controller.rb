class SessionsController < ApplicationController

  def new
    redirect_to videos_path if logged_in? 
  end
  
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password]) && user.active?
      session[:user_id] = user.id 
      flash[:notice] = "Successfully logged in, welcome #{current_user.full_name}"
      redirect_to current_user.admin? ? admin_dashboard_path : videos_path
    else
      flash[:error] = user.active? ? "Invalid username/password. Please try again" : "We're sorry but your account has been suspended. Please contact an administrator." 
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:error] = "You've logged out"
    redirect_to root_path
  end
end
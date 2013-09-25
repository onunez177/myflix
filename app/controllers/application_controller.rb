class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user # !! forces the current_user method to become a boolean, will return true if someone is logged in
  end
  
  def require_user
    unless logged_in?
    flash[:notice] = "Restricted to registered users only, please login."
    redirect_to login_path
    end
  end
end

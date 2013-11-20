class AdminsController < ApplicationController
  before_action :require_admin

  def require_admin
	  flash[:error] = "You are not authorized to access that page." unless current_user.admin?
	  redirect_to root_path unless current_user.admin?
  end
end

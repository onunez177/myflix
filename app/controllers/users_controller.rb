class UsersController < ApplicationController
  before_action :require_user, only: [:show]
  
  def new
    session[:invite_id] = nil 
    @invite = Invite.find_by_token(params[:invite_id])
    
    if @invite
      session[:invite_id] = @invite.id
      @user = User.new(email: @invite.new_user_email)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(users_params)
    register = Registration.new(@user,params[:stripeToken],session[:invite_id]).register # services/registration.rb      
    if register.successful?
      flash[:notice] = "You've successfully registered, please log in."
      redirect_to login_path
    else
      flash[:error] = register.error_message 
    end
  end

  def show
    @user = User.find(params[:id])
  end
  
  private
  
  def users_params
    params.require(:user).permit(:full_name, :password, :email) 
  end
end
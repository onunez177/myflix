class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)

    if @user.save
      flash[:notice] = "You've successfully registered, please log in."
      redirect_to login_path
    else 
      render :new
    end
  end


  private
  
  def users_params
    params.require(:user).permit(:full_name, :password, :email) # extract strong parameters to a method
  end
end
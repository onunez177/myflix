class UsersController < ApplicationController
   
  def new
    session[:invite_id] = nil #initialize as nil
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
      
    if @user.valid? # check validations on user info first
      charge = charge_card  
      if charge.successful? # check that card was processed
        @user.save # we only save the user if card was successfully charged
        UserMailer.delay.notify_new_user(@user)
        create_relationship unless session[:invite_id] == nil 
        flash[:notice] = "You've successfully registered, please log in."
        redirect_to login_path
      end
    else 
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end
  
  private
  
  def users_params
    params.require(:user).permit(:full_name, :password, :email) # extract strong parameters to a method
  end

  def create_relationship
    invite = Invite.find(session[:invite_id])
    @user.following << invite.user
    invite.user.following << @user
    session[:invite_id] = nil
  end
  
  def charge_card # we will run validations using the custom js form, no need for validations here now   
    StripeWrapper::Charge.create(
        :amount => 999, # amount in cents, again
        :card => params[:stripeToken],
        :description => "#{@user.email} payment to sign up for MyFlix"
      )
   end
end
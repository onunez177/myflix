require 'pry'

class Registration
 
  def initialize(user,token,invite_id)
    @user = user
    @token = token
    @invite_id = invite_id
  end
  
  def register
		if @user.valid?
			charge = StripeWrapper::Charge.create(:amount => 999, :card => @token,
			                                      :description => "#{@user.email} payment to sign up for MyFlix")
			if charge.successful? 
				@user.save 
				UserMailer.delay.notify_new_user(@user)
				create_relationship unless @invite_id == nil 
		    self
			else
				@errors = charge.error_message
			  self
			end
		else
		  @errors = "Invalid user information, please check your input."
	    self
	  end    
	end

  def successful?
    true unless @errors
  end

  def error_message
    @errors
  end

  private

  def create_relationship
    invite = Invite.find(@invite_id)
    @user.following << invite.user
    invite.user.following << @user
  end
end
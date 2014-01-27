class Registration
 
  def initialize(user,token,invite_id)
    @user = user
    @token = token
    @invite_id = invite_id
  end
  
  def register
    if @user.valid?
      customer = StripeWrapper::Customer.create(@user, @token)
      if customer.successful? 
        @user.stripe_customer_id = customer.customer_token
        @user.save 
        UserMailer.delay.notify_new_user(@user)
        create_relationship
        self
      else
        @errors = customer.error_message
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
    if @invite_id
      invite = Invite.find(@invite_id)
      @user.following << invite.user
      invite.user.following << @user
    end
    @user.following << User.first unless @user.following.include?(User.first)
  end
end

class BillingDecorator < Draper::Decorator
  delegate_all

  def initialize
    @customer ||= Stripe::Customer.retrieve(current_user.stripe_customer_id)
  end

end

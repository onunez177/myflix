class BillingDecorator < Draper::Decorator
  delegate_all

  def get_stripe_info
    @customer ||= Stripe::Customer.retrieve(current_user.stripe_customer_id)
  end

end
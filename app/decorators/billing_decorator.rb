class BillingDecorator < Draper::Decorator
  attr_reader :customer
  delegate_all

  def initialize(user)
    @customer ||= Stripe::Customer.retrieve(user.stripe_customer_id)
  end

end

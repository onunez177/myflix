Stripe.api_key = ENV['STRIPE_SECRET_KEY'] # Set your api key

StripeEvent.setup do
  subscribe 'charge.succeeded' do |event|
    user = User.find_by(stripe_customer_id: event.data.object.customer)
    Payment.create(user: user, amount: event.data.object.amount, reference_id: event.data.object.id)
  end
end
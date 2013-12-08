Stripe.api_key = ENV['STRIPE_SECRET_KEY'] # Set your api key

StripeEvent.setup do
  subscribe 'charge.succeeded' do |event|
    Payment.create
  end
end
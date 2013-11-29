require 'spec_helper'
require 'pry'

describe 'StripeWrapper::Charge' do
	before do
    Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
  end
	
	context "with valid credit card" do
    it "charges the card succesfully", :vcr do
      card_number = "4242 4242 4242 4242"
      token = stripe_token(card_number) # stripe_token /support/macros.rb
      test_charge = StripeWrapper::Charge.create(amount: 999, card: token.id)
      expect(test_charge).to be_successful
    end
	end

	context "with invalid credit card" do
    it "does not charge the card successfully", :vcr do
      card_number = "4000 0000 0000 0002"
      token = stripe_token(card_number) # stripe_token /support/macros.rb
      test_charge = StripeWrapper::Charge.create(amount: 999, card: token.id)
      expect(test_charge).not_to be_successful
    end
    it "creates and parses an error message", :vcr do
    	card_number = "4000 0000 0000 0002"
      token = stripe_token(card_number) # stripe_token /support/macros.rb
      test_charge = StripeWrapper::Charge.create(amount: 999, card: token.id)
      expect(test_charge.error_message).to eq("Your card was declined.")
    end
	end

end
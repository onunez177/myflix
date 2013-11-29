require 'spec_helper'
require 'pry'

describe 'StripeWrapper::Charge' do
	before do
    Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
  end
	
	context "with valid credit card" do
<<<<<<< HEAD
    it "charges the card succesfully" do
=======
    it "charges the card succesfully", :vcr do
>>>>>>> mod13
      card_number = "4242 4242 4242 4242"
      token = stripe_token(card_number) # stripe_token /support/macros.rb
      test_charge = StripeWrapper::Charge.create(amount: 999, card: token.id)
      expect(test_charge).to be_successful
    end
	end

	context "with invalid credit card" do
<<<<<<< HEAD
    it "does not charge the card successfully" do
=======
    it "does not charge the card successfully", :vcr do
>>>>>>> mod13
      card_number = "4000 0000 0000 0002"
      token = stripe_token(card_number) # stripe_token /support/macros.rb
      test_charge = StripeWrapper::Charge.create(amount: 999, card: token.id)
      expect(test_charge).not_to be_successful
    end
<<<<<<< HEAD
    it "creates and parses an error message" do
=======
    it "creates and parses an error message", :vcr do
>>>>>>> mod13
    	card_number = "4000 0000 0000 0002"
      token = stripe_token(card_number) # stripe_token /support/macros.rb
      test_charge = StripeWrapper::Charge.create(amount: 999, card: token.id)
      expect(test_charge.error_message).to eq("Your card was declined.")
    end
	end
end
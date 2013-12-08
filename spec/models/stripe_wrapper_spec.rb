require 'spec_helper'
require 'pry'

describe 'StripeWrapper' do
  before do
    Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
  end

  describe 'StripeWrapper::Charge' do
  	describe '.create' do
      
      context "with valid credit card" do
        it "charges the card succesfully", :vcr do
          card_number = "4242 4242 4242 4242" # this number provided by stripe api as a good cc number
          token = stripe_token(card_number) # stripe_token /support/macros.rb
          test_charge = StripeWrapper::Charge.create(amount: 999, card: token.id)
          expect(test_charge).to be_successful
        end
    	end

    	context "with invalid credit card" do
        it "does not charge the card successfully", :vcr do
          card_number = "4000 0000 0000 0002" # this number provided by stripe api as rejected cc number
          token = stripe_token(card_number) 
          test_charge = StripeWrapper::Charge.create(amount: 999, card: token.id)
          expect(test_charge).not_to be_successful
        end
        it "creates and parses an error message", :vcr do
        	card_number = "4000 0000 0000 0002"
          token = stripe_token(card_number)
          test_charge = StripeWrapper::Charge.create(amount: 999, card: token.id)
          expect(test_charge.error_message).to eq("Your card was declined.")
        end
      end
    
    end
  end
  
  describe 'StripeWrapper::Customer' do
    describe '.create' do
      
      it "creates a new customer with valid card", :vcr do
        simon = Fabricate(:user)
        card_number = "4242 4242 4242 4242"
        token = stripe_token(card_number)
        test_customer = StripeWrapper::Customer.create(simon, token.id)
        expect(test_customer).to be_successful
      end
   
      it "does not create a new customer with invalid card", :vcr do
        simon = Fabricate(:user)
        card_number = "4000 0000 0000 0002"
        token = stripe_token(card_number)
        test_customer = StripeWrapper::Customer.create(simon, token.id)
        expect(test_customer).not_to be_successful
      end
   
      it "returns the error message for the user", :vcr do
        simon = Fabricate(:user)
        card_number = "4000 0000 0000 0002"
        token = stripe_token(card_number)
        test_customer = StripeWrapper::Customer.create(simon, token.id)
        expect(test_customer.error_message).to eq("Your card was declined.")
      end
    end
  
  end
end
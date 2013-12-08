require 'spec_helper'
require 'pry'

describe "Registration" do
  
  describe "#register" do
    context "with valid user information and valid credit card" do
	    before do
	      customer = double(:customer, successful?: true)
	      StripeWrapper::Customer.stub(:create).and_return(customer)
	    end

	    after do 
        ActionMailer::Base.deliveries.clear
	    end

	    it "creates the new user" do
	      Registration.new(Fabricate.build(:user),'fake_token',nil).register
	      expect(User.count).to eq(1)
	    end

	    it "sends the user a welcome email" do
	    	Registration.new(Fabricate.build(:user, email: "test@test.com"),'fake_token', nil).register
	      expect(ActionMailer::Base.deliveries.last.to).to eq(["test@test.com"])
	    end
	    
	    it "creates a relationship for invited users" do
	      simon = Fabricate(:user)
	      invite = Invite.create(user: simon, new_user_email: "test@test.com")
	      Registration.new(Fabricate.build(:user, email: "test@test.com"),'fake_token', invite.id).register
	      expect(simon.following.count).to eq(1)
	    end  
  
      it "automatically creates a friendship between new user and first user in system" do
      	paul = Fabricate(:user)
      	simon = Fabricate(:user)
      	invite = Invite.create(user: simon, new_user_email: "test@test.com")
      	Registration.new(Fabricate.build(:user, email: "test@test.com"), 'fake_token', invite.id).register
      	expect(paul.followers.count).to eq(1)
      end

	    it "returns successful? as true" do
	    	register = Registration.new(Fabricate.build(:user, email: "test@test.com"),'fake_token', nil).register
	      expect(register.successful?).to eq(true)
	    end
	  
	  end	
  
	  context "with valid user information and invalid credit card charge" do # not implemented yet 
	    before do
        customer = double(:customer, successful?: false, error_message: "Your card was declined.")
        StripeWrapper::Customer.stub(:create).and_return(customer)
	      ActionMailer::Base.deliveries.clear
	    end

	    it "does not create a new user" do
	    	Registration.new(Fabricate.build(:user),'fake_token',nil).register
	      expect(User.count).to eq(0)
	    end
	    it "does not send out an email" do
        Registration.new(Fabricate.build(:user),'fake_token',nil).register
	      expect(ActionMailer::Base.deliveries.last).to eq(nil)
	    end
	    it "returns successful? as false" do
        register = Registration.new(Fabricate.build(:user),'fake_token',nil).register
        expect(register.successful?).to eq(nil)
	    end
	    it "sets the error message" do
	    	register = Registration.new(Fabricate.build(:user),'fake_token',nil).register
        expect(register.error_message).to eq("Your card was declined.")
	    end
	  end
    
    context "with invalid user information" do
      it "does not create a new user" do
        Registration.new(User.new(full_name: "Herp Derp", email: " "),'fake_token', nil).register
        expect(User.count).to eq(0)
      end
      it "does not charge the credit card" do
        StripeWrapper::Charge.should_not_receive(:create)
        Registration.new(User.new(email: ''),'fake_token',nil).register
      end

      it "sets the error message for the user" do
      	register = Registration.new(User.new(email: ''),'fake_token',nil).register
        expect(register.error_message).to eq("Invalid user information, please check your input.")
      end
    end
  end
end

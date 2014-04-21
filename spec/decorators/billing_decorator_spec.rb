require 'spec_helper'

describe "BillingDecorator" do
  before do
    simon = Fabricate(:user, stripe_customer_id: 'cus_36BKEwNwQtK495')
  end
  
  it "retrieves the correct customer information from stripe", :vcr do 
    decorated_user = BillingDecorator.new(simon)
    expect(simon.stripe_customer_id).to eq(decorated_user.customer.id)
  end
  it "sets the last payment date for the view" do 
  	# 
    decorated_user = BillingDecorator.new(simon)
    expect(decorated_user.next_billing_date).not_to eq(nil)  
  end
  it "sets the next payment due date for the view"
  it "sets the subscription plan for the view"
  it "retrieves the last 10 payments for the view"
end
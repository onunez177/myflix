require 'spec_helper'

describe "handle a failed payment for user" do
	let(:event_data) do 
		{
		  "id" => "evt_1036Dr2EgJ8VpLXrjyDkHDB3",
		  "created" => 1386723824,
		  "livemode" => false,
		  "type" => "charge.failed",
		  "data" => {
		    "object" => {
		      "id" => "ch_1036Dr2EgJ8VpLXr8YB2tJQ5",
		      "object" => "charge",
		      "created" => 1386723823,
		      "livemode" => false,
		      "paid" => false,
		      "amount" => 999,
		      "currency" => "usd",
		      "refunded" => false,
		      "card" => {
		        "id" => "card_1036Dq2EgJ8VpLXr9Vk7to0B",
		        "object" => "card",
		        "last4" => "0341",
		        "type" => "Visa",
		        "exp_month" => 9,
		        "exp_year" => 2017,
		        "fingerprint" => "QTUVjnIh06NHjZdh",
		        "customer" => "cus_36BGucfphUeBQL",
		        "country" => "US",
		        "name" => nil,
		        "address_line1" => nil,
		        "address_line2" => nil,
		        "address_city" => nil,
		        "address_state" => nil,
		        "address_zip" => nil,
		        "address_country" => nil,
		        "cvc_check" => "pass",
		        "address_line1_check" => nil,
		        "address_zip_check" => nil
		      },
		      "captured" => false,
		      "refunds" => [],
		      "balance_transaction" => nil,
		      "failure_message" => "Your card was declined.",
		      "failure_code" => "card_declined",
		      "amount_refunded" => 0,
		      "customer" => "cus_36BGucfphUeBQL",
		      "invoice" => nil,
		      "description" => "Recurring monthly bill",
		      "dispute" => nil,
		      "metadata" => {}
		    }
		  },
		  "object" => "event",
		  "pending_webhooks" => 1,
		  "request" => "iar_36Dr2nBIH6IwUv"
		}	
	end
    it "deactivates the user account when a charge fails" do
      simon = Fabricate(:user, stripe_customer_id: "cus_36BGucfphUeBQL")
      post "/stripe_events", event_data
      expect(simon.reload).not_to be_active
    end
    it "sends an email notifying the customer of suspended account"
end

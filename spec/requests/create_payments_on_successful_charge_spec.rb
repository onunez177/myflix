require 'spec_helper'

describe "Create payment on successful charge" do
	let(:event_data) do 
		{
  "id" => "evt_1035Bb2EgJ8VpLXr5KKsnCi0",
  "created" => 1386484794,
  "livemode" => false,
  "type" => "charge.succeeded",
  "data" => {
    "object" => {
      "id" => "ch_1035Bb2EgJ8VpLXrZUC9O7Hl",
      "object" => "charge",
      "created" => 1386484794,
      "livemode" => false,
      "paid" => true,
      "amount" => 999,
      "currency" => "usd",
      "refunded" => false,
      "card" => {
        "id" => "card_1035Bb2EgJ8VpLXrIo7ieyfn",
        "object" => "card",
        "last4" => "4242",
        "type" => "Visa",
        "exp_month" => 12,
        "exp_year" => 2016,
        "fingerprint" => "NjRZljRJ10zh6goe",
        "customer" => "cus_35BbKQrp3m67sq",
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
      "captured" => true,
      "refunds" => [],
      "balance_transaction" => "txn_1035Bb2EgJ8VpLXrLrWIrwyx",
      "failure_message" => nil,
      "failure_code" => nil,
      "amount_refunded" => 0,
      "customer" => "cus_35BbKQrp3m67sq",
      "invoice" => "in_1035Bb2EgJ8VpLXro6wGMdXG",
      "description" => nil,
      "dispute" => nil,
      "metadata" => {}
    }
  },
  "object" => "event",
  "pending_webhooks" => 1,
  "request" => "iar_35BbtULLdPWCWs"
}
end
	it "creates a payment with the webhook from stripe for successful charge", :vcr do
    post "/stripe_events", event_data
	  expect(Payment.count).to eq(1)
	end
  it "creates a payment associated with the user" do 
    simon = Fabricate(:user, stripe_customer_id: "cus_35BbKQrp3m67sq") # token taken from the dummy event data above
    post "/stripe_events", event_data
    expect(Payment.first.user).to eq(simon)
  end
  it "creates payment with the amount for the subscription" do
    simon = Fabricate(:user, stripe_customer_id: "cus_35BbKQrp3m67sq")
    post "/stripe_events", event_data
    expect(Payment.first.amount).to eq(999)
  end
  it "creates payment with reference number from stripe" do
    simon = Fabricate(:user, stripe_customer_id: "cus_35BbKQrp3m67sq")
    post "/stripe_events", event_data
    expect(Payment.first.reference_id).to eq("ch_1035Bb2EgJ8VpLXrZUC9O7Hl")
  end

end

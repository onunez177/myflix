require 'spec_helper'

feature "admin views recent payments" do
  background do
    luna = Fabricate(:user)
    payment = Fabricate(:payment, amount: 999, user: luna)
  end

  scenario "admin signs in and views payments" do
  	simon = Fabricate(:user, admin: true)

  	sign_in(simon)
  	expect(page).to have_content("Admin Page")
  	click_on "View Payments"
  end

  scenario "user signs in and cannot see payments"
end
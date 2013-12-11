require 'spec_helper'

feature "admin views recent payments" do
  background do
    luna = Fabricate(:user, full_name: "Luna Sandhu", email: "lunabean@test.com")
    payment = Fabricate(:payment, amount: 999, user: luna)
  end

  scenario "admin signs in and views payments" do
  	simon = Fabricate(:user, admin: true)

  	sign_in(simon)
  	expect(page).to have_content("Admin Page")
  	click_on "View Payments"

  	expect(page).to have_content("$9.99")
  	expect(page).to have_content("Luna Sandhu")
  	expect(page).to have_content("lunabean@test.com")
  end

  scenario "user signs in and cannot see payments" do
    bomba = Fabricate(:user)
    sign_in(bomba)
    visit admin_payments_path
    
    expect(page).not_to have_content("$9.99")
    expect(page).to have_content("You are not authorized to access that page.")
  end
end
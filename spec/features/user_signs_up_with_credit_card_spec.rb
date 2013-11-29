require 'spec_helper'

feature "User signs up with credit card", {js: true} do
	background do
    visit register_path
	end

	scenario "Valid user info and valid credit card" do
	  valid_user_info
	  valid_card_info
    
    expect(page).to have_content("You've successfully registered, please log in.")
	end

  scenario "Valid user info and invalid credit card" do
    valid_user_info
    invalid_card_info
    expect(page).to have_content("This card number looks invalid")
  end
  
  scenario "Valid user info and declined card" do
    valid_user_info

    fill_in "Credit Card Number", with: "4000 0000 0000 0002"
    fill_in "Security Code", with: "123"
    select "11 - November", from: "date_month"
    select "2016", from: "date_year"
    click_on "Sign Up"

    expect(page).to have_content("Your card was declined.")
  end

	scenario "Invalid user info and valid credit card" do
    invalid_user_info
    valid_card_info
    expect(page).to have_content("can't be blank")
	end
  
  scenario "Invalid user info and invalid credit card" do
    invalid_user_info
    invalid_card_info
    expect(page).to have_content("This card number looks invalid")
  end
end

def valid_user_info
  fill_in "Full Name", with: "Paul Sandhu"
  fill_in "Email Address", with: "test@test.com"
  fill_in "Password", with: "password"
end

def invalid_user_info
	fill_in "Full Name", with: "Paul Sandhu"
  fill_in "Email Address", with: "test@test.com"
  fill_in "Password", with: ""
end

def valid_card_info
  fill_in "Credit Card Number", with: "4242 4242 4242 4242"
  fill_in "Security Code", with: "123"
  select "11 - November", from: "date_month"
  select "2016", from: "date_year"
  click_on "Sign Up"
end

def invalid_card_info
  fill_in "Credit Card Number", with: "4242"
  fill_in "Security Code", with: "123"
  select "11 - November", from: "date_month"
  select "2016", from: "date_year"
  click_on "Sign Up"
end
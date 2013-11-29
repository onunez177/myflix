require 'spec_helper'
require 'pry'

feature "User invites a friend, and friend joins the site" do
  given (:simon) { Fabricate(:user) }
  
  before do
    clear_emails # because our tests run in random order, we want to clear email queue
   
    sign_in(simon)
    click_link "Invite"
     
    fill_in "Friend's Name", with: "Paul Sandhu"
    fill_in "Friend's Email Address", with: "test@test.com"
    fill_in "Invitation Message", with: "You should join this awesome site!"
    click_on "Send Invite"
       
    visit logout_path 
  end
  
  scenario "User joins site through invitation email", { js: true } do #stripe ui uses js so need to set to true here
	 
    open_email("test@test.com")
    expect(current_email).to have_content("Click here to sign up!")
    
    current_email.click_link "Click here to sign up!"

    fill_in "Full Name", with: "Paul Sandhu"
    fill_in "Password", with: "password"
    fill_in "Credit Card Number", with: "4242 4242 4242 4242"
    fill_in "Security Code", with: "123"
    select "11 - November", from: "date_month"
    select "2016", from: "date_year"
    click_on "Sign Up"
    expect(page).to have_content("You've successfully registered, please log in.")
    
    paul = User.find_by_email("test@test.com")
    
    visit login_path
    fill_in "email", with: "test@test.com"
    fill_in "password", with: "password"
    click_button "Sign in"

    visit people_path
    expect(page).to have_content(simon.full_name)
    
   end
end


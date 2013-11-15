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
  
  scenario "User joins site through invitation email" do
	 
    open_email("test@test.com")
    expect(current_email).to have_content("Click here to sign up!")
    
    current_email.click_link "Click here to sign up!"
    fill_in "Full Name", with: "Paul Sandhu"
    fill_in "Password", with: "password"
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

# Question for TAs: if I try to sign_in(paul) this test will fail	
# paul cannot sign in due his password being nil, even though it should be
# "password". Why is this new user's password field nil even after a reload?

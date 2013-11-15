require 'spec_helper'

feature "User interacts with password reset functionality" do
  scenario "user resets password and logs in with new password" do
    
    simon = Fabricate(:user, password: "old_password") 
    
    visit root_path
    click_link("Sign In")
    click_link("Forgot Password?")


    fill_in "email", :with => simon.email
    click_on "Send Email"
    
    open_email(simon.email)
    current_email.click_link "Please click this link to reset your password"
    expect(page).to have_content("Reset Your Password")
  
    fill_in "password", :with => "new_password"
    click_on "Reset Password"
    expect(page).to have_content("Successfully updated password.")
    
    fill_in "email", :with => simon.email
    fill_in "password", :with => "new_password"
    click_on "Sign in"
    
    expect(page).to have_content("welcome #{simon.full_name}")
  end
end
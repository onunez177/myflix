require 'spec_helper'

feature 'User signs in' do
  scenario "with valid username and password" do
    bob = Fabricate(:user)
    visit login_path
    fill_in "email", with: bob.email
    fill_in "password", with: bob.password
    click_button "Sign in"
    page.should have_content "welcome #{bob.full_name}"
  end
end
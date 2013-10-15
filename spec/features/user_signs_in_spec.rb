require 'spec_helper'

feature 'User signs in' do
  background do
    User.create(full_name: "Bob Dole", password: "password", email: "test@email.com")
  end
  scenario "with existing username" do
    visit login_path
    fill_in "email", with: "test@email.com"
    fill_in "password", with: "password"
    click_button "Sign in"
    page.should have_content "welcome Bob"
  end
end
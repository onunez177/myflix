require 'spec_helper'

feature 'User signs in' do
  scenario "with valid username and password" do
    simon = Fabricate(:user)
    sign_in(simon) # sign_in is a method that has been extracted to support/macros
    page.should have_content "welcome #{simon.full_name}"
  end
end
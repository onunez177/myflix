require 'spec_helper'

feature 'User signs in' do
  scenario "with valid username and password" do
    simon = Fabricate(:user)
    sign_in(simon)
    page.should have_content "welcome #{simon.full_name}"
  end
end
require 'spec_helper'
require 'pry'

feature "User signs in and interacts with the queue" do
  given (:simon) { Fabricate(:user) }

  scenario "user visits front page and then logs in" do
	  visit root_path
	  click_link('Sign In')
	  expect(page).to have_content "Email Address"
  end
  
  scenario "user signs in and then adds videos to the queue" do
    comedy = Fabricate(:genre)
    futurama = Fabricate(:video, name: "Futurama")  
    family_guy = Fabricate(:video, name: "Family Guy")
    transformers = Fabricate(:video, name: "Transformers")
    
    futurama.genres << comedy
    family_guy.genres << comedy
    transformers.genres << comedy
    
    sign_in(simon)
       
    find("a[href='/videos/#{futurama.id}']").click
    expect(page).to have_content(futurama.name)
    end
  
	
end

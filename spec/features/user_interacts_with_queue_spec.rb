require 'spec_helper'
require 'pry'

feature "User signs in and interacts with the queue" do
  given (:simon) { Fabricate(:user) }

  scenario "user visits front page and goes to the sign in page" do
	  visit root_path
	  click_link("Sign In")
	  expect(page).to have_content "Email Address"
  end
  
  scenario "user signs in, adds videos to their queue, and re-orders the queue" do # this needs to be broken into multiple tests
    comedy = Fabricate(:genre)
    futurama = Fabricate(:video, name: "Futurama")  
    family_guy = Fabricate(:video, name: "Family Guy")
    transformers = Fabricate(:video, name: "Transformers")
    
    futurama.genres << comedy
    family_guy.genres << comedy
    transformers.genres << comedy
    
    sign_in(simon)
    
    add_video_to_queue(futurama) # find in the macros
    expect(page).to have_content("Futurama")
    
    visit root_path

    add_video_to_queue(family_guy)
    click_link "My Queue"
    expect(page).to have_content("Family Guy")    

    visit root_path
    add_video_to_queue(transformers)
    expect(page).to have_content("Already in Queue") # Already in Queue button should display here
    
    click_link "My Queue"        

    fill_in("box_#{futurama.id}", :with => 3)
    fill_in("box_#{family_guy.id}", :with => 1)
    fill_in("box_#{transformers.id}", :with => 2)
    
    click_on "Update Instant Queue"
     
    expect(find_field("box_#{futurama.id}").value).to eq("3")
    expect(find_field("box_#{transformers.id}").value).to eq("2")
    expect(find_field("box_#{family_guy.id}").value).to eq("1")
    
  end
  
	
end

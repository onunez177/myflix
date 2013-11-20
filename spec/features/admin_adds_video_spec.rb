require 'spec_helper'
require 'pry'

feature "admin signs in and adds a video" do
  scenario "admin signs in and adds video to system" do
    simon = Fabricate(:user, admin: true)
    Comedy = Fabricate(:genre)

    visit root_path
    
    click_link("Sign In")
    fill_in "Email", :with => simon.email
    fill_in "Password", :with => simon.password
    click_button "Sign in"
    expect(page).to have_content("Admin Page")
   
    click_link "Add Video"
    expect(page).to have_content("Add a New Video")

    fill_in "Name", :with => "Test Video Name"
    page.select Comedy.name, :from => "Genre"
    fill_in "Description", :with => "This is a test video!"
    page.attach_file("video_poster_url", "spec/features/test1.txt") # need a txt file or something similar here
    page.attach_file("video_small_cover_url", "spec/features/test2.txt")
    fill_in "Video URL", :with => "http://test_url.com"
    
    click_button "Add Video"  
    expect(page).to have_content("Added video")
  
    video = Video.first
    
    visit videos_path
    click_on("video_#{video.id}")

    expect(page).to have_content("#{video.name}")
  end
end



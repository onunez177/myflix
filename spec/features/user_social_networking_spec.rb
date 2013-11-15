require 'spec_helper'

feature "User interacts with social networking features" do 
  given (:simon) { Fabricate(:user) }
  
  
  scenario "User adds a follower, and then unfollows them" do
    paul = Fabricate(:user)
    
    comedy = Fabricate (:genre)
    futurama = Fabricate(:video)
    futurama.genres << comedy

    review = Fabricate(:review, video: futurama, creator: paul)

    sign_in(simon)
    
    click_on("video_#{futurama.id}")
    expect(page).to have_content(paul.full_name)

    click_on("#{paul.full_name}")
    expect(page).to have_content("Follow")

    click_link "Follow"
    expect(simon.following.count).to eq(1)
    
    visit people_path
    expect(page).to have_content("#{paul.full_name}")
    
    click_on("del_#{paul.full_name}")
    expect(page).not_to have_content("#{paul.full_name}")
  end
end
def sign_in(a_user=nil)
  user = a_user || Fabricate(:user)
  visit login_path
  fill_in "email", with: user.email
  fill_in "password", with: user.password
  click_button "Sign in"
end

def add_video_to_queue(video)
  click_on("video_#{video.id}") #click the video link, then we're routed to the video show page
  click_on("Add to My Queue") #add video to the queue
end
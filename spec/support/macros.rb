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

def set_current_user(a_user=nil)
  user = a_user || Fabricate(:user)
  session[:user_id] = user.id
end

def current_user
  User.find(session[:user_id])
end

def logout_user
  session[:user_id] = nil
end

def set_admin(user=nil)
  user = Fabricate(:user, admin: true)
  session[:user_id] = user.id
end

def stripe_token(card_number) # pass in CC number so we can test various types of CC inputs
  Stripe::Token.create(
      :card => {
      :number => card_number,
      :exp_month => 11,
      :exp_year => 2016,
      :cvc => "314"
      },
  )
end

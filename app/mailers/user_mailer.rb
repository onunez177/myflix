class UserMailer < ActionMailer::Base

  def notify_new_user(user)
    @user = user
    mail from: 'welcome@myflix.com', to: user.email, subject: "Welcome to MyFlix!"
  end

  def password_reset(user)
    @user = user  
    mail from: 'resetpasswords@myflix.com', to: user.email, subject: "Password Reset Instructions"
  end
  
  def send_invite_email(invite, friend_name, message)
    @user = User.find(invite.user_id)
    @invite = invite
    @friend_name = friend_name
    @message = message
    
    mail from: 'invites@myflix.com', to: @invite.new_user_email, subject: "Invitation to join MyFlix from #{@user.full_name}"
  end
end

class UserMailer < ActionMailer::Base

	def notify_new_user(user)
    @user = user
    mail from: 'welcome@myflix.com', to: user.email, subject: "Welcome to MyFlix!"
	end

  def password_reset(user)
    @user = user  
    mail from: 'resetpasswords@myflix.com', to: user.email, subject: "Password Reset Instructions"
  end

end
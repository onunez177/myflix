class UserMailer < ActionMailer::Base

	def notify_new_user(user)
    @user = user
    mail from: 'welcome@myflix.com', to: user.email, subject: "Welcome to MyFlix!"
	end

end
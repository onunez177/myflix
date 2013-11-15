class InvitesController < ApplicationController
before_action :require_user

  
  def create
    if params[:email].blank? || params[:friend_name].blank?
      flash[:error] = "Name or Email cannot be blank, please re-enter."
      render :new
    elsif User.find_by_email(params[:email])
      flash[:error] = "That person is already registered with MyFlix."  
      redirect_to new_invite_path
    else
      invite = Invite.new(user_id: current_user.id, new_user_email: params[:email])
      invite.save
      
      UserMailer.send_invite_email(invite, params[:friend_name], params[:message]).deliver
      
      flash[:success] = "Your invitation to #{params[:friend_name]} has been sent!"
      redirect_to new_invite_path 
    end
  end
end

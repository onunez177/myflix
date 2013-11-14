class InvitesController < ApplicationController
before_action :require_user

  
  def create
    if params[:email].blank? || params[:friend_name].blank?
      flash[:error] = "Name or Email cannot be blank, please re-enter."
      render :new
    else 
      flash[:success] = "Your invitation to #{params[:friend_name]} has been sent!"
      UserMailer.send_invite_email(current_user, params[:email], 
                                   params[:friend_name], params[:message]).deliver
      redirect_to new_invite_path 
    end
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?, :in_queue?, :queue_position, :user_has_queue?, :user_reviewed?, :can_follow?
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user # !! forces the current_user method to become a boolean, will return true if someone is logged in
  end
  
  def require_user
    unless logged_in?
    flash[:notice] = "Restricted to registered users only, please login."
    redirect_to login_path
    end
  end

  def user_has_queue?
    !!current_user.queued_videos.any?
  end
  
  def in_queue? # this method allows us to modify the "+ My Queue" button in the video show page "+ My Queue" will not display if already in queue
    !!QueuedVideo.find_by(user_id: current_user.id, video_id: @video.id)
  end

  def queue_position # this method is used to display the position of a video in the video show page
    position = QueuedVideo.find_by(user_id: current_user.id, video_id: @video.id)
    position.queue_position
  end 

  def user_reviewed?
    !!Review.find_by(user_id: current_user.id, video_id: @video.id)
  end

  def can_follow? # method that allows us to display follow button on user show page
    true unless (Relationship.find_by(user_id: current_user.id, following_id: @user.id) || current_user == @user)
  end
end

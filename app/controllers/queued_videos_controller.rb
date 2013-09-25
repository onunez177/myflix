class QueuedVideosController < ApplicationController
  before_action :require_user
  before_action :set_queue, only: [:index, :create]
  
  def index
    
  end

  def create
    video = Video.find(params[:video_id])
    in_queue = @queued_videos.where(video_id: video.id)
    position = @queued_videos.count + 1
    
    
    if in_queue.any? #need to create a helper method called in_queue?
      flash[:error] = "That video is already in your queue."
      redirect_to :back
    else
      QueuedVideo.create(user_id: current_user.id, video_id: video.id, queue_position: position)
      flash[:notice] = "Added video to queue"
      redirect_to :back
    end
  end

  private
  def set_queue #this will set the queue to the current users' queue
    @queued_videos = current_user.queued_videos
  end

end
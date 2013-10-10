class QueuedVideosController < ApplicationController
  before_action :require_user
  before_action :set_queue, only: [:index, :create, :destroy, :update]
  
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

  def destroy
    queued_video = @queued_videos.find_by(user_id: current_user.id, queue_position: params[:id])
    queued_video.destroy
    redirect_to my_queue_path
  end

  def update
    # this code works, but should be extracted to a method, also: need better variable names
    # there is no protection against junk data being entered for positions.
    queue = params[:queued_videos]
    queue.each do |queue|
      update = @queued_videos.find(queue['id'])
      update.queue_position = queue['position']
      update.save
    end
    redirect_to my_queue_path
  end

  private
  def set_queue #this will set the queue to the current users' queue
    @queued_videos = current_user.queued_videos
  end

  def set_queue_order
    
  end
end
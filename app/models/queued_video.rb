class QueuedVideo < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  
  validates_numericality_of :queue_position, only_integer: true  

  default_scope { order('queue_position ASC') } # hardcode the order to list the items by queue position

  def video_name
    video.name
  end
  
  def genre_name # this is a better name for the method
    video.genres.first.name
  end

  def rating
    review = Review.where(user_id: user.id, video_id: video.id).first

    review.rating if review #exists / isn't nil
  end
end
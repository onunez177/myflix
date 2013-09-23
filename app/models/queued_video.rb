class QueuedVideo < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  def video_name
    video.name
  end
  
  def video_genre
    video.genres.first.name
  end

  def rating
    review = Review.where(user_id: user.id, video_id: video.id).first
    if review # exists / isn't nil
      review.rating # return the rating of the review
    else
      "Not yet rated"
    end
  end
end
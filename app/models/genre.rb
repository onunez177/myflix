class Genre < ActiveRecord::Base
  has_many :video_genres
  has_many :videos, through: :video_genres

  def recent_videos 
    videos.order("created_at DESC").limit(6) # limiting it to 7
  end
end

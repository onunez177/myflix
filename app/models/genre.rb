class Genre < ActiveRecord::Base
  has_many :video_genres
  has_many :videos, through: :video_genres

  def self.recent_videos(genre) # accepts a genre and then returns the 6 most recent films of that genre
    genre.videos.limit(6).reverse
  end
end

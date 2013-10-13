class Video < ActiveRecord::Base
  has_many :reviews, -> { order("created_at DESC") } # hard code the order of the reviews to display newest first
  has_many :video_genres
  has_many :genres, through: :video_genres
  
  has_many :queued_videos
  has_many :users, through: :queued_videos
  
  validates :name, :description, presence: true

  
  def self.search_by_name(search_word)
    Video.where("name LIKE ?", "#{search_word}%")  
  end
end

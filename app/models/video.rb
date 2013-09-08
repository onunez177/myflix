class Video < ActiveRecord::Base
  has_many :video_genres
  has_many :genres, through: :video_genres

  validates :name, :description, presence: true

  
  def self.search_by_name(search_word)
    Video.where("name LIKE ?", "#{search_word}%")  
  end
end

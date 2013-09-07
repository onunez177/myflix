class Video < ActiveRecord::Base
  has_many :video_genres
  has_many :genres, through: :video_genres

  validates :name, :description, presence: true

  # this method will allow us to pass in a search parameter and return an array of results 
  # I think using using a logic controller of "if Video.search_by_name?" in the views/controller
  # will allow me to parse if results are empty to the user
  def self.search_by_name(search_word)
    Video.where("name LIKE ?", "#{search_word}%")  
  end
end

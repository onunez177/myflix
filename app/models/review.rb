class Review < ActiveRecord::Base
  belongs_to :creator, :class_name => "User", :foreign_key => "user_id" 
  # this will change the association of review to creator when referring to the user that made the review

  belongs_to :video

  validates :body, presence: true, 
            length: { minimum: 10 } # no garbage one word reviews
  validates :rating, presence: true


def self.avg_rating
  average('rating').round(1) # Active Record will return the average value of this column with 1 decimal pt
end
  
end
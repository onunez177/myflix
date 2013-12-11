class VideoDecorator < Draper::Decorator
  delegate_all

  def rating
    if model.reviews.any? 
      "Average user rating: #{model.reviews.avg_rating}/5.0"
    else
      "No user ratings for this movie."
    end
  end
end

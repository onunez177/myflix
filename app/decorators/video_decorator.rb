# we use decorators to extract out any logic in our view templates and also
# to move view template logic away from the model/controller layer

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

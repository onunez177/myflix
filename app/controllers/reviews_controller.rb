class ReviewsController < ApplicationController
  before_action :require_user
  
  def create
    
    @video = Video.find(params[:video_id])
    review = Review.new(review_params)
    review.video = @video  
    review.creator = current_user
    @reviews = @video.reviews
    
    if review.save
      flash[:notice] = "Thanks for your review #{current_user.full_name}!"
      redirect_to video_path(@video)
    else
      redirect_to video_path(@video), notice: "There was an error saving your review."
    end
	end

  private
  def review_params
    params.require(:review).permit(:body, :rating)
  end
end

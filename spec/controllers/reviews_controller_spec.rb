require 'spec_helper'


describe ReviewsController do
  before { set_current_user }

  describe "POST create" do
	  context "with valid input" do
      it "assigns @video to the correct video" do
        video1 = Fabricate(:video)
        video2 = Fabricate(:video)
       
        post :create, video_id: video2, review: Fabricate.to_params(:review)
        expect(assigns(:video)).to eq(video2)
      end

	    it "re-assigns the @reviews variable for the video view" do
        video1 = Fabricate(:video)
                        
        post :create, video_id: video1, review: Fabricate.to_params(:review)
        expect(assigns(:reviews)).not_to eq(nil)
      end
         
	    it "creates a new review for the video" do
        simon = Fabricate(:user) 
        video1 = Fabricate(:video)
        review = Fabricate(:review, creator: simon, video: video1)
                
        post :create, video_id: video1, review: Fabricate.to_params(:review)
        expect(video1.reviews.count).to eq(2)
      end
      
      it "redirects to the video show page" do
        video1 = Fabricate(:video)
   
        post :create, video_id: video1, review: Fabricate.to_params(:review)
        expect(response).to redirect_to video_path(video1)
      end
      
    end
    context "with invalid input" do
      it "sets the error message" do 
        video1 = Fabricate(:video)
      
        post :create, video_id: video1, review: {rating: 5, body: ''}
        expect(flash[:notice]).to eq("There was an error saving your review.")    
      end
      it "redirects back to the video show page" do
        video1 = Fabricate(:video)
      
        post :create, video_id: video1, review: {rating: 5, body: ''}
        expect(response).to redirect_to video_path(video1)
      end
    end
  end
end

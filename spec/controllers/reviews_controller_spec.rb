require 'spec_helper'


describe ReviewsController do
  describe "POST create" do
    it "finds the correct video" do
      video = Video.create(name: "Test Name", description: "Test Description")
      review = Fabricate(:review)
      post :create, video_id: video.id # this simulates the params hash
      expect(assigns(:video)).to eq(video)
    end
    it "instantiates a new review in the db"
    it "associates the review with the correct video"
    it "associates the review with the correct user"
  end
end
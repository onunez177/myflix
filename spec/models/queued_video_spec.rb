require 'spec_helper'

describe QueuedVideo do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  
  describe "video_name" do   
    it "returns the name of the associated video" do
      video = Fabricate(:video, name: "Test 1")
      queued_video = Fabricate(:queued_video, video: video)
      expect(queued_video.video_name).to eq("Test 1")
    end
  end

 describe "genre_name" do   
    it "returns the genre of the associated video" do
      video = Fabricate(:video, name: "Test 1")
      genre = Fabricate(:genre, name: "Action")
      video.genres << genre
      queued_video = Fabricate(:queued_video, video: video)
      expect(queued_video.genre_name).to eq("Action")
    end
  end
  
  describe "rating" do
    it "returns the rating of the video" do
      user = Fabricate(:user)
      video = Fabricate(:video) 
      review = Fabricate(:review, rating: "2", video: video)
      queued_video = Fabricate(:queued_video, video: video, user: user)
      user.reviews << review
      expect(queued_video.rating).to eq(2)
    end
    
    it "returns 'Not yet yated', when a user has not rated a movie" do
      user = Fabricate(:user)
      video = Fabricate(:video) 
      queued_video = Fabricate(:queued_video, video: video, user: user)
      expect(queued_video.rating).to eq("Not yet rated")
    end
  end
end
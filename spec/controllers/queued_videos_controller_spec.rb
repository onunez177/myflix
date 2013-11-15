require 'spec_helper'
require 'pry'

describe QueuedVideosController do
  let (:video1) { Fabricate(:video) }
  let (:video2) { Fabricate(:video) }
  let (:video3) { Fabricate(:video) }
  
  before do
    set_current_user # we'll just set a user for all these tests
  end
  
  describe "GET index" do
    it "sets @queued_videos to the queue of the current user" do
      paul = Fabricate(:user)
      session[:user_id] = paul.id
      queued_video1 = Fabricate(:queued_video, user: paul)
      queued_video2 = Fabricate(:queued_video, user: paul)
      get :index
      expect(assigns(:queued_videos)).to match_array([queued_video1, queued_video2])
    end
    
    it "redirects to the sign in page for unauthenticated users" do
      logout_user
      get :index
      expect(response).to redirect_to login_path
    end
  end 	

  describe "POST create" do
    
    context "if video is not already in queued" do
      it "inserts the video to the users' queue" do
        video = Fabricate(:video)
        post :create, video_id: video
        expect(current_user.queued_videos.count).to eq(1)
      end
      
      it "adds a new video to the last position in the user queue" do
        video = Fabricate(:video)
        QueuedVideo.create(user: current_user, video: video, queue_position: 1)
        video2 = Fabricate(:video)
       
        post :create, video_id: video2
        expect(current_user.queued_videos.last.video).to eq(video2)
      end
      
      it "redirects back to the video page" do
        video = Fabricate(:video)
        post :create, video_id: video
        expect(response).to redirect_to video_path(video)
      end
    end
    
    context "if video is already in the queue" do
      it "displays an error message" do
        video = Fabricate(:video)
        QueuedVideo.create(user: current_user, video: video, queue_position: 1)
        post :create, video_id: video
        expect(flash[:error]).to eq("That video is already in your queue.")
      end
      it "does not insert the video into the users' queue" do
        video = Fabricate(:video)
        QueuedVideo.create(user: current_user, video: video, queue_position: 1)
        post :create, video_id: video
        expect(current_user.queued_videos.count).to eq(1)
      end
    end
  end

  describe "POST update" do
    
    context "with valid inputs" do
      it "reorders the user's queue" do
        queued_video1 = Fabricate(:queued_video, video: video1, user: current_user)
        queued_video2 = Fabricate(:queued_video, video: video2, user: current_user)
        queued_video3 = Fabricate(:queued_video, video: video3, user: current_user) 
        
        post :update, queued_videos: [ {id: queued_video3, position: 1},
                                       {id: queued_video2, position: 2},
                                       {id: queued_video1, position: 3} ]
        
        expect(current_user.queued_videos).to match_array( [queued_video3,queued_video2,queued_video1] )
      end
      it "updates the video rating if not blank" do
        queued_video1 = Fabricate(:queued_video, video: video1, user: current_user)
        post :update, queued_videos: [{id: queued_video1, position: 1, rating: 5}]
        expect(current_user.queued_videos.first.rating).to eq(5)
      end
    end

    context "with invalid input" do
      it "does not change the user's queue" do
        queued_video1 = Fabricate(:queued_video, video: video1, user: current_user, queue_position: 1)
        queued_video2 = Fabricate(:queued_video, video: video2, user: current_user, queue_position: 2)
             
        post :update, queued_videos: [ {id: queued_video1, position: 5.5}, {id: queued_video2, position: "bad input"} ]
        expect(current_user.queued_videos).to match_array([queued_video1,queued_video2])
      end
    end

    it "normalizes the queue positions" do
      queued_video1 = Fabricate(:queued_video, video: video1, user: current_user)
      queued_video2 = Fabricate(:queued_video, video: video2, user: current_user)
      
      post :update, queued_videos: [{id: queued_video1, position: 500}, {id: queued_video2, position: 2500}]
      expect(queued_video1.reload.queue_position).to eq(1)
    end

  end
  
  describe "DELETE destroy" do
    it "removes the video from current users queue" do
      queued_video1 = Fabricate(:queued_video, video: video1, user: current_user)
      queued_video2 = Fabricate(:queued_video, video: video2, user: current_user)
      
      delete :destroy, id: video1
      expect(current_user.queued_videos.first.video).to eq(video2)
    end
    it "normalizes the new queue positions" do   
      queued_video1 = Fabricate(:queued_video, video: video1, user: current_user)
      queued_video2 = Fabricate(:queued_video, video: video2, user: current_user)
      queued_video3 = Fabricate(:queued_video, video: video3, user: current_user) 
      
      delete :destroy, id: video2    
      expect(queued_video3.reload.queue_position).to eq(2)
    end
  end
end
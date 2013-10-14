require 'spec_helper'
require 'pry'

describe QueuedVideosController do
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
      get :index
      expect(response).to redirect_to login_path
    end
  end 	

  describe "POST create" do
  
    context "with valid input" do
      it "finds the correct video" do
      end
      
      it "inserts the correct video to the users' queue" do
      end
      it "redirects back to the video page" do
      end
    end
    
    context "with invalid input" do
      it "displays an error message" do
      end
      it "does not insert the video into the users' queue" do
      end
    end
  
  end

  describe "DELETE update" do
  end

end
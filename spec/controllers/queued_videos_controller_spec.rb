require 'spec_helper'

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
end
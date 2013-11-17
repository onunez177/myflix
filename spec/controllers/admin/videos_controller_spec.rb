require 'spec_helper'

describe Admin::VideosController do

  describe "GET new" do
    it "sets the @video variable to a new instance of video" do
      simon = Fabricate(:user)
      set_admin
      get :new
      expect(assigns(:video)).to be_instance_of(Video)
    end
    
    it "redirects regular users to the home page" do
      simon = Fabricate(:user)
      set_current_user(simon)
      get :new
      expect(response).to redirect_to root_path
    end
  end
end
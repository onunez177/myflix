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

  describe "POST create" do
    context "with valid input" do
      it "creates a new video"
      it "assigns the correct genre to the video"
      it "redirects to the add new video page"
      it "sets the flash message"
    end
    context "with invalid input" do  
      it "renders the new template" 
      it "does not create a new video"
      it "sets the error message"
    end
  end
end
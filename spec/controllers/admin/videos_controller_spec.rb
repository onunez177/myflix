require 'spec_helper'

describe Admin::VideosController do

  describe "GET new" do
    it "sets the @video variable to a new instance of video" do
      simon = Fabricate(:user)
      set_admin(simon)
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
      it "creates a new video" do
        videos = Video.all
        set_admin
        genre = Fabricate(:genre)
        post :create, video: Fabricate.to_params(:video), genres: genre.id
        expect(videos.count).to eq(1)      
      end
      it "assigns the correct genre to the video" do
        set_admin
        genre = Fabricate(:genre)
        post :create, video: Fabricate.to_params(:video), genres: genre.id
        expect(Video.first.genres.first).to eq(genre)
      end
      it "redirects to the add new video page" do
        set_admin
        genre = Fabricate(:genre)
        post :create, video: Fabricate.to_params(:video), genres: genre.id
        expect(response).to redirect_to new_admin_video_path
      end
      it "sets the flash message" do
        set_admin
        genre = Fabricate(:genre)
        post :create, video: Fabricate.to_params(:video), genres: genre.id
        expect(flash[:success]).to be_present
      end
    end
    context "with invalid input" do  
      it "renders the new template" do
        set_admin
        post :create, video: {name: '', description: ''}
        expect(response).to render_template :new
      end
      it "does not create a new video" do
        set_admin
        post :create, video: {name: '', description: ''}
        expect(Video.all.count).to eq(0)
      end
    end
  end
end
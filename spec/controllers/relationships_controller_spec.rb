require 'spec_helper'
require 'pry'
describe RelationshipsController do
  before do
    paul = Fabricate(:user)
    set_current_user(paul) # setting paul into the session (macros)
  end
  
  describe "GET index" do
    it "renders the index page" do
      get :index
      expect(response).to render_template :index
    end
    
    it "sets @following to people the current user is following" do
      simon = Fabricate(:user)
      bombi = Fabricate(:user)
      luna = Fabricate(:user)
      
      current_user.following << [simon,luna]

      get :index
      expect(assigns(:following)).to eq([simon,luna])
    end
  
    it_behaves_like "require_user" do
      let(:action) { get :index }
    end
  end

  describe "DELETE destroy" do
    it "deletes the relationship if the current user is the follower"
    it "redirects to the people page"
    it "does not delete the relationship if the current user is not the follower"
  end
end
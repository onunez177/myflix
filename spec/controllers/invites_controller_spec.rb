require 'spec_helper'

describe InvitesController do
  before do
    simon = Fabricate(:user)
    set_current_user(simon)
  end
  describe "GET new" do
    it "renders the invite page" do
      get :new
      expect(response).to render_template :new
    end
  end  

  describe "POST create" do
    context "with invalid input" do
      it "re-renders the new invite page" do
        post :create, email: '', friend_name: 'Paul Sandhu'
        expect(response).to render_template :new
      end
      it "sets the error message" do
        post :create, email:'', friend_name: 'Paul Sandhu'
        expect(flash[:error]).to eq('Name or Email cannot be blank, please re-enter.')
      end
    end
    
    context "with valid input" do
      it "sends an invite email to the new user" do 
        post :create, email:'test@test.com', friend_name: 'Paul Sandhu'
        expect(ActionMailer::Base.deliveries.last.to).to eq(['test@test.com'])
      end
      it "re-directs back to the new invite page" do
        post :create, email:'test@test.com', friend_name: 'Paul Sandhu'
        expect(response).to redirect_to new_invite_path
      end
    end
  end
end
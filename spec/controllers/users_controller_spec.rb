require 'spec_helper'
require 'pry'

describe UsersController do
  describe "GET new" do 
    it "sets the @user variable" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
    
    context "if user is invited to the site" do 
      it "sets the @invite variable via the invite token" do
        simon = Fabricate(:user)
        invite = Invite.create(user: simon, new_user_email: "paul@test.com")
        get :new, invite_id: invite.token
        expect(assigns(:invite)).to eq(invite)
      end
      it "sets the session invite_id to the id of the inviter" do
        simon = Fabricate(:user)
        invite = Invite.create(user: simon, new_user_email: "paul@test.com")
        get :new, invite_id: invite.token
        expect(session[:invite_id]).to eq(simon.id)
      end
    end
  end

  describe "POST create" do
    context "with successful registration" do
      it "redirects to the login page" do
        result = double(:register_result, successful?: true)
        Registration.any_instance.should_receive(:register).and_return(result)
        post :create, user: Fabricate.to_params(:user), stripeToken: "2187645"
        expect(response).to redirect_to login_path
      end
      it "sets the flash to success" do
        result = double(:register_result, successful?: true)
        Registration.any_instance.should_receive(:register).and_return(result)
        post :create, user: Fabricate.to_params(:user), stripeToken: "2187645"
        expect(flash[:notice]).to eq("You've successfully registered, please log in.")
      end
    end
    
    context "with unsuccesful registration" do
      it "renders the new template" do
        result = double(:register_result, successful?: false, error_message: "Failure")
        Registration.any_instance.should_receive(:register).and_return(result)
        post :create, user: Fabricate.to_params(:user), stripeToken: "2187645"
        expect(response).to render_template :new
      end
      it "flashes the error messages" do
        result = double(:register_result, successful?: false, error_message: "Failure")
        Registration.any_instance.should_receive(:register).and_return(result)
        post :create, user: Fabricate.to_params(:user), stripeToken: "2187645"
        expect(flash[:error]).to eq("Failure")
      end
    end
  end 
  
  describe "GET show" do
    it "sets the @user"
    it "requires a user to be logged in"
  end
end  
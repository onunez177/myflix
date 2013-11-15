require 'spec_helper'
require 'pry'


describe PasswordResetsController do

	describe "POST create" do
    context "with invalid input" do
      it "redirects back to the password reset page" do
        post :create, email: ''
        expect(response).to redirect_to new_password_reset_path
      end
      it "sets an error message for the user" do 
        post :create, email: 'test@test.com'
        expect(flash[:error]).to eq('Invalid email address please try again')
      end
    end
    
    context "with valid email" do
	    it "redirects to the user to the cofirm password reset page" do
        simon = Fabricate(:user)
        post :create, email: simon.email
        expect(response).to redirect_to confirm_password_reset_path
      end

	    it "sends an email to the user so they can reset their password" do
        simon = Fabricate(:user)
        post :create, email: simon.email 
        expect(ActionMailer::Base.deliveries.last.to).to eq([simon.email])
      end
    end
  end

  describe "GET edit" do
    context "with invalid/expired token" do
      it "redirects the user back to the password reset page" do
        simon = Fabricate(:user)
        get :edit, id: 'not simon token'
        expect(response).to redirect_to new_password_reset_path
      end

      it "sets the error message" do  
        simon = Fabricate(:user)
        get :edit, id: 'not simon token'
        expect(flash[:error]).to eq('Sorry, but that link has expired.')
      end
    end
    context "with valid token do" do
      it "renders the edit template" do
	      simon = Fabricate(:user)
	      get :edit, id: simon.token
	      expect(response).to render_template :edit
      end
    end
  end
  
  describe "PATCH update" do
    context "with invalid password" do
      it "re-renders the edit template" do
        simon  = Fabricate(:user)
        patch :update, id: simon.token, password: '1234'
        expect(response).to render_template :edit
      end
      it "sets the error message" do
        simon = Fabricate(:user)
        patch :update, id: simon.token, password: '1234'
        expect(flash[:error]).to eq('Password too short, must be minimum 5 characters.')
      end
    end
    context "with valid password" do
      it "updates the user password" do 
        simon = Fabricate(:user)
        patch :update, id: simon.token, password: 'password'
        expect(simon.reload.authenticate('password')).to be_true # why does this test have to be worded this way?
      end
      it "redirects to the login in page" do
        simon = Fabricate(:user)
        patch :update, id: simon.token, password: 'password'
        expect(response).to redirect_to login_path
      end
      
      it "generates a new token for the user" do   
        simon = Fabricate(:user)
        old_token = simon.token      
        patch :update, id: old_token, password: 'password'
        new_token = simon.reload.token
        expect(old_token).not_to eq(new_token)
      end
    end
  end
end
require 'spec_helper'

describe PasswordResetsController do

	describe "POST create" do
    context "with invalid input" do
      it "redirects back to the password reset page if email is blank" do
        post :create, email: ''
        expect(response).to redirect_to password_reset_path
      end
      it "sets an error message if user doesn't exist" do 
        post :create, email: 'test@test.com'
        expect(flash[:error]).to eq('Invalid email address please try again')
      end
    end
    
    context "with valid email" do
	    it "redirects to the user to the cofirm password reset page"
	    it "sends an email to the user with instructions"
	  end
  end
end
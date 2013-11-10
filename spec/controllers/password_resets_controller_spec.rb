require 'spec_helper'

describe PasswordResetsController do

	describe "POST create" do
    context "with invalid input" do
      it "redirects back to the password reset page if email is blank"
      it "sets the error message if user doesn't exist"
    end
    
    context "with valid input" do
	    it "finds the correct user"
	    it "sends an email to the user with instructions"
	  end
  end
end
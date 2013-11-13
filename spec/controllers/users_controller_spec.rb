require 'spec_helper'

describe UsersController do
  describe "GET new" do 
    it "sets the @user variable" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid input" do
      before { post :create, user: Fabricate.to_params(:user) }
      
      it "creates a new user" do
        expect(User.count).to eq(1)
      end  
      it "redirects to the sign in page" do
        expect(response).to redirect_to login_path
      end
    end
    context "with invalid input" do

      before do
        post :create, user: {full_name: 'Bob', email: 'email here', password: ''}
      end

      it "does not create the user" do        
        expect(User.first).to eq(nil)
      end
       
      it "renders the :new template" do
        expect(response).to render_template :new
      end
      it "sets the @user variable" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end 
    
    context "sending emails" do
      after { ActionMailer::Base.deliveries.clear } #clear the deliveries queue to a blank state to ensure tests are accurate

      it "sends out an email to the user with valid inputs" do
        post :create, user: {full_name: 'Simon Sandhu', email: 'simon@gmail.com', password: 'password'}
        expect(ActionMailer::Base.deliveries.last.to).to eq(['simon@gmail.com'])
      end
      it "sends out an email containing the user's name with valid inputs" do
        post :create, user: {full_name: 'Simon Sandhu', email: 'simon@gmail.com', password: 'password'}
        expect(ActionMailer::Base.deliveries.last.body).to have_content('Simon Sandhu')
      end
      it "does not send out an email with invalid inputs" do
        post :create, user: {full_name: 'Simon Sandhu', email: 'simon@gmail.com', password: ''}
        expect(ActionMailer::Base.deliveries.last).to eq(nil)
      end
    end   
 
  end
end
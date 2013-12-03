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
    before do
      charge = double(:charge, successful?: true) # creating a "double" of charge 
      StripeWrapper::Charge.stub(:create).and_return(charge) # calling the create method and forcing a return of the "double"
    end
    
    context "with valid input" do
      it "creates a new user" do
        post :create, user: Fabricate.to_params(:user), stripeToken: "29347356"
        expect(User.count).to eq(1)
      end  
      it "redirects to the sign in page" do
        post :create, user: Fabricate.to_params(:user), stripeToken: "2187645"
        expect(response).to redirect_to login_path
      end
    
     context "with invited user" do
       it "creates a relationship" do
         simon = Fabricate(:user)
         invite = Invite.create(user: simon, new_user_email: "paul@test.com")
         session[:invite_id] = simon.id

         post :create, user: Fabricate.to_params(:user), stripeToken: "748274"
         expect(simon.following.count).to eq(1)
        end
      end
    end

    context "with valid user info and declined card" do

      it "sets the @user variable" do
        charge = double(:charge, successful?: false, error_message: "Your card was declined.")
        StripeWrapper::Charge.stub(:create).and_return(charge)
        post :create, user: Fabricate.to_params(:user)
        expect(assigns(:user)).to be_instance_of(User)
      end

      it "does not save the user to the database" do        
        charge = double(:charge, successful?: false, error_message: "Your card was declined.")
        StripeWrapper::Charge.stub(:create).and_return(charge)
        post :create, user: Fabricate.to_params(:user)
        expect(User.first).to eq(nil)
      end
       
      it "renders the :new template" do
        charge = double(:charge, successful?: false, error_message: "Your card was declined.")
        StripeWrapper::Charge.stub(:create).and_return(charge)
        post :create, user: Fabricate.to_params(:user)
        expect(response).to render_template :new
      end
    end 
    
    context "with invalid user information and valid credit card info" do
      it "does not charge the credit card" do
        StripeWrapper::Charge.should_not_receive(:create) #we assert that the wrapper should not call the create method
        post :create, user:{ full_name: 'Simon Sandhu', email: '' }
      end
    end


    context "sending emails" do
      before do
        charge = double(:charge, successful?: true) # creating a "double" of charge
        StripeWrapper::Charge.stub(:create).and_return(charge) # calling the create method and forcing a return of the "double"
      end 
    
      after { ActionMailer::Base.deliveries.clear } #clear the deliveries queue to a blank state to ensure tests are accurate

      it "sends out an email to the user with valid inputs" do
        post :create, user: {full_name: 'Simon Sandhu', email: 'simon@gmail.com', password: 'password'}, stripeToken: "37483"
        expect(ActionMailer::Base.deliveries.last.to).to eq(['simon@gmail.com'])
      end
      it "sends out an email containing the user's name with valid inputs" do
        post :create, user: {full_name: 'Simon Sandhu', email: 'simon@gmail.com', password: 'password'}, stripeToken: "e7548"
        expect(ActionMailer::Base.deliveries.last.body).to have_content('Simon Sandhu')
      end
      it "does not send out an email with invalid inputs" do
        post :create, user: {full_name: 'Simon Sandhu', email: 'simon@gmail.com', password: ''}
        expect(ActionMailer::Base.deliveries.last).to eq(nil)
      end
    end   
 
  end
end
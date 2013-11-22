require 'spec_helper'
require 'pry'

describe UsersController do
  before do
    Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
  end

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

    context "with valid input" do
          
      it "creates a new user" do
        
        post :create, user: Fabricate.to_params(:user), stripeToken: stripe_token.id
        expect(User.count).to eq(1)
      end  
      it "redirects to the sign in page" do
        post :create, user: Fabricate.to_params(:user), stripeToken: stripe_token.id
        expect(response).to redirect_to login_path
      end
    
     context "with invited user" do
       it "creates a relationship" do
         simon = Fabricate(:user)
         invite = Invite.create(user: simon, new_user_email: "paul@test.com")
         session[:invite_id] = simon.id

         post :create, user: Fabricate.to_params(:user), stripeToken: stripe_token.id
         expect(simon.following.count).to eq(1)
        end

        it "sets the session invite_id to nil" do
          simon = Fabricate(:user)
          invite = Invite.create(user: simon, new_user_email: "paul@test.com")
          session[:invite_id] = simon.id

          post :create, user: Fabricate.to_params(:user), stripeToken: stripe_token.id
          expect(session[:invite_id]).to eq(nil)
        end
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
        post :create, user: {full_name: 'Simon Sandhu', email: 'simon@gmail.com', password: 'password'}, stripeToken: stripe_token.id
        expect(ActionMailer::Base.deliveries.last.to).to eq(['simon@gmail.com'])
      end
      it "sends out an email containing the user's name with valid inputs" do
        post :create, user: {full_name: 'Simon Sandhu', email: 'simon@gmail.com', password: 'password'}, stripeToken: stripe_token.id
        expect(ActionMailer::Base.deliveries.last.body).to have_content('Simon Sandhu')
      end
      it "does not send out an email with invalid inputs" do
        post :create, user: {full_name: 'Simon Sandhu', email: 'simon@gmail.com', password: ''}
        expect(ActionMailer::Base.deliveries.last).to eq(nil)
      end
    end   
 
  end
end
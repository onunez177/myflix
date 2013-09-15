require 'spec_helper'

describe VideosController do
  
  describe "GET index" do
  end
 
  describe "GET show" do
	  context "with a user logged in" do
	    before do
        user = User.create(full_name: 'Paul', email: 'paul@paul.com', password: 'password')
        session[:user_id] = user.id
      end  
        it "renders the show template" do
		      video = Video.create(name: 'Test', description: 'testing!')
		      get :show, id: video
		      expect(response).to render_template :show
		    end
      
      describe "POST search" do
        it "returns a video when search term partial matches a title" do
          Video.create(name: 'Hoobly', description: 'Doobly')
          int = 0
          4.times do
            Video.create(name: "Test #{int}", description: "testing #{int}")
            int += 1
          end
            post :search, search_term: 'Hoo'
            expect(assigns(:results).size).to eq 1
        end
      end
 	  end
  end

  
end
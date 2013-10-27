shared_examples "require_user" do 
  it "redirects to the login page" do
    logout_user # macro
    action
    response.should redirect_to login_path
  end
end
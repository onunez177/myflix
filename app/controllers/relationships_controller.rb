class RelationshipsController < ApplicationController
  before_action :require_user

  def index
    @following = current_user.following
  end

  def destroy
    
    redirect_to people_path
  end
end
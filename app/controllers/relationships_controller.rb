class RelationshipsController < ApplicationController
  before_action :require_user

  def index
    @following = current_user.following
  end

  def destroy
    follower = Relationship.find_by(following_id: params[:id])
    follower.destroy if current_user == follower.user # simple check to make sure only current user can destroy their own relationships
    redirect_to people_path
  end

  def create
    Relationship.create(user_id: current_user.id, following_id: params[:id]) unless current_user.id == params[:id].to_i # params comes in as string!
    
    redirect_to people_path  
  end
end
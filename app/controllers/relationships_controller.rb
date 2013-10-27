class RelationshipsController < ApplicationController
  before_action :require_user

  def index
    @following = current_user.following
  end

  def destroy
    follower = Relationship.find_by(following_id: params[:id])
    follower.destroy if current_user == follower.user
    redirect_to people_path
  end
end
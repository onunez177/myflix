class VideosController < ApplicationController
  before_action :require_user, only: [:show, :index, :search]  
  
  def show
    @video = Video.find(params[:id])
    @reviews = @video.reviews
  end

  def index 
    @genres = Genre.all
  end

  def search
    @results = Video.search_by_name(params[:search_term])
  end
end


# TODO
# 1. Extract views to partials
# 2. Implement validations for the search bar so blank entry cannot be valid
#    right now a blank entry returns all videos (this is horrible)

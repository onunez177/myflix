# TODO
# 1. Extract views to partials
# 2. Implement validations for the search bar so blank entry cannot be valid
#    right now a blank entry returns all videos (this is horrible)

class VideosController < ApplicationController
   
  def show
    @video = Video.find(params[:id])
  end

  def index 
    @genres = Genre.all
  end

  def search
    @search_term = params[:name]
    @results = Video.search_by_name(@search_term)
  end
end

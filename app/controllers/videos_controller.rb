# TODO
# 1. Extract views to partials
# 2. Implement Jquery or validations for the search bar so blank entry cannot be valid
#    right now a blank entry returns all videos (this is horrible)

class VideosController < ApplicationController
   
  def show
    @video = Video.find(params[:id])
  end

  def index 
      
    @genres = Genre.all.each do |genre|  # iterate through all the genres and then pull only the recent 6 videos
              Genre.recent_videos(genre)
              end 
  end

  def search
    @search_term = params[:name]
    @results = Video.search_by_name(@search_term)
  end
end

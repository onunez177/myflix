class VideosController < ApplicationController
  before_action :require_user, only: [:show, :index, :search]  
  
  def show
    @video = VideoDecorator.new(Video.find(params[:id])) # wrap the object in a decorator
    @reviews = @video.reviews
  end

  def index 
    @genres = Genre.all
  end

  def search
    @results = Video.search_by_name(params[:search_term])
  end

  def play
    @video = VideoDecorator.new(Video.find(params[:video_id]))
    @reviews = @video.reviews
  end
end


# TODO
# 1. Extract views to partials


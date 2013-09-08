class VideosController < ApplicationController

  def show
    @video = Video.find(params[:id])
  end

  def index
    @videos = Video.all
    @genres = Genre.all
  end

  # TODO
  # Results view can be extracted to a partial? Need to clean it up.
  def search
    @results = Video.search_by_name(params[:name])
    @search_term = params[:name]
  end
end

class UiController < ApplicationController
  before_filter do
    redirect_to :root if Rails.env.production?
  end

  layout "application"

  def index
  end

  def home
    @video = Video.all
    @comedy = Genre.find(1) 
    @drama = Genre.find(2)
    @action = Genre.find(3) 
  end
end

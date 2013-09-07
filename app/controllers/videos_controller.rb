class VideosController < ApplicationController

  def show
    @video = Video.find(params[:id])
      render 'ui/video.html.haml'
  end
end

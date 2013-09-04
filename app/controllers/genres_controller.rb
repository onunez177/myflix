class GenresController < ApplicationController
  def show
    @genre = Genre.find(params[:id])
      render 'ui/genre.html.haml'
  end
end

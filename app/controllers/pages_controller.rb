class PagesController < ApplicationController

  def front
    redirect_to videos_path if logged_in? #re-direct the user back to their videos page if logged into site
  end

end

class Admin::VideosController < AdminsController

	def index
	  
	end

	def new
	  @video = Video.new
  end

	def create
	  
    @video = Video.new(videos_params)
    if @video.save
      @video.genres << Genre.find(params[:genres])  
      flash[:success] = "Added video #{@video.name}!"
      redirect_to new_admin_video_path
    else
      flash[:error] = "Error adding video, please check your input."
      render :new
    end
  end


  private
  
  def videos_params
    params.require(:video).permit(:name, :description, :poster_url, :small_cover_url)
  end
end
class Admin::VideosController < AdminsController

	def index
	  
	end

	def new
	  @video = Video.new
  end

	def create
	  
  end


  private
  
  def video_params
  
  end
end
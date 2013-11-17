class Admin::VideosController < AdminsController

	def index
	  
	end

	def new
	  @video = Video.new
  end

	def create
	  binding.pry
  end

end
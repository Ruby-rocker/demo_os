class Admin::BannersController < Admin::AdminController
	def index
		@banner = Banner.all
	end

	def new
		@banner = Banner.new
	end
	def create
		@banner = Banner.new(params[:banner])
		respond_to do |format|
			if @banner.save
				format.html { redirect_to admin_banners_path, :notice => 'banner was successfully created.' }
			else
				format.html { render :action => "new" }
			end
		end
	end
end

class Admin::UploadsController < Admin::AdminController
	def index
     	#render :file => 'app/views/admin/uploads/uploadfile.html.erb'
	    @all_banner = Dir.open("#{RAILS_ROOT}/public/images/pages/home/slideshow").entries.find_all{|item| item =~ /[a-zA-Z0-9\s_-]+\.(jpg|JPG|jpeg|png)/ } #|| []
  	end
  	def create
  		@banner = DataFile.save(params[:upload])
	    redirect_to admin_uploads_path, :notice => "File has been uploaded successfully"
  	end
  	def uploadFile
	    DataFile.save(params[:upload])
	    redirect_to admin_uploads_path, :notice => "File has been uploaded successfully"
  	end
  	def cleanup
    	File.delete("#{RAILS_ROOT}/public/images/pages/home/slideshow/#{params[:filename]}") if File.exist?("#{RAILS_ROOT}/public/images/pages/home/slideshow/#{params[:filename]}")
    	redirect_to admin_uploads_path, :notice => "File has been deleted successfully"
  	end
end

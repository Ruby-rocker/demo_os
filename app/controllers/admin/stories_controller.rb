class Admin::StoriesController < Admin::AdminController

	
	def index
	  @map_javascript = true
	  @stories = Story.paginate(:page => params[:page], :include => [:geocoding, :user], :order => 'created_at DESC')
	end  
  
  
  
	def feature  
    @story = Story.find(params[:id])
    if @story.feature!
      flash[:notice] = "Story successfully featured at:<br/> #{Time.now.strftime('%x %X')}"
    else
      flash[:error] = "Story could not be featured."
    end
    redirect_back_or_default featured_admin_stories_path
	end
	
	def unfeature
    @story = Story.find(params[:id])
    if @story.unfeature!
      flash[:notice] = "Story successfully un-featured at:<br/> #{Time.now.strftime('%x %X')}"
    else
      flash[:error] = "Story could not be un-featured."
    end
    redirect_back_or_default featured_admin_stories_path
	end
	
	
	
	def publish
	  @story = Story.find(params[:id])
    if @story.publish!
      flash[:notice] = "Story successfully published at:<br/> #{Time.now.strftime('%x %X')}"
    else
      flash[:error] = "Story could not be published."
    end
    redirect_back_or_default admin_stories_path
	end
	
	
	def unpublish
	  @story = Story.find(params[:id])
    if @story.unpublish!
      flash[:notice] = "Story successfully un-published at:<br/> #{Time.now.strftime('%x %X')}"
    else
      flash[:error] = "Story could not be un-published."
    end
    redirect_back_or_default admin_stories_path
	end
	
	

      
  
end
class FeaturedController < ApplicationController

  before_filter :login_required
  
  def create
   @user = User.find_by_login(params[:login])
	 @story = @user.stories.find_by_path(params[:path])
	  
   @feature = @story.featured.build(:story => @story)
    	
  	if @feature
      flash[:notice] = "Story featured!"
  	else
      flash[:error] = "<b>Story could not be featured!</b><br/>Are you sure you haven't already featured this story?"
  	end
    
    redirect_to admin_featured_path
    
  end
    
  def destroy
    
    @user #= User.find_by_login(params[:login])
    @bookmark = Bookmark.find(params[:bookmark])
    @user = @bookmark.user
    @bookmark.destroy
    
    redirect_to user_stories_path(@user)
    
  end
  
  private

  def authorized?
  	return (logged_in? && current_user.has_role?('admin'))
  end
      
end

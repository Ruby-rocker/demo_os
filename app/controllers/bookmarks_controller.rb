class BookmarksController < ApplicationController
  
  def create
   @user = User.find_by_login(params[:login])
	 @story = @user.stories.find_by_path(params[:path])
	  	
    if current_user
     
    	@bookmark = current_user.bookmarks.build(:story => @story)
    	
    	if @bookmark.save
        flash[:notice] = "Bookmark saved!"
    	else
        flash[:error] = "<b>Bookmark could not be saved!</b><br/>Are you sure you haven't already bookmarked this story?"
    	end
    else
      flash[:notice] = "Sorry, you must be logged in to use this feature."
    end
    redirect_to user_story_path(@user, @story)
  end
    
  def destroy
    
    @user #= User.find_by_login(params[:login])
    @bookmark = Bookmark.find(params[:bookmark])
    @user = @bookmark.user
    @bookmark.destroy
    
    redirect_to user_path(@user)
    
  end
  
  
end

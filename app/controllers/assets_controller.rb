class AssetsController < ApplicationController

  before_filter :defaults, :except => [:new, :create]
  before_filter :login_required
  protect_from_forgery :except => :create
  
  def new
    @user = current_user
    @asset = @user.assets.build
    respond_to do |format|
      format.html {render :layout => false }
    end
  end
  
  def create
    @asset = Asset.new(params[:asset])
    @asset.user = current_user
    @asset.save
    @insertString = "<img src='#{@asset.src.url(:large)}'/>"
    render :layout => false
  end

  def destroy
  
    allow_delete = false
    case @parent.class.to_s
      when 'Paragraph'
        allow_delete = @parent.user && @parent.user == current_user
        path = edit_story_path(@parent.user, @parent.story)
    end
    if allow_delete
      @asset.destroy
      flash[:notice] = "The asset was successfully deleted."
    end    
    
    redirect_to path
        
    #render :text => "deleting: #{allow_delete} - #{@parent.user}"
        
  end

  def defaults
    @asset = Asset.find(params[:id])
    @parent = @asset.attachable
  end
  
  def authorized?
    if action_name == 'new' || action_name == 'create'
      logged_in?
    else
      logged_in? && (@parent.user ? @parent.user == current_user : false)
    end
  end
  

end

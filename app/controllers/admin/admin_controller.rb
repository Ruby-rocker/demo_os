class Admin::AdminController < ActionController::Base
	
	before_filter :login_required
	
  include AuthenticatedSystem
  include RoleRequirementSystem

  helper :application
  	
  def index
    @stylesheet = 'admin/index'
  	redirect_to account_path unless authorized?
  end

  def stories
    store_location
    @top_bar_partial = 'admin/stories/top_bar'
  	@map_javascript = true
		@stories = Story.paginate(:all, :page => params[:page], :include => ['user', 'geocoding', 'view_counts'], :order => 'created_at desc')
    render :template => 'admin/stories/index'
  end
  
  def featured
    store_location
    @stylesheet = 'modules/list'
    @top_bar_partial = 'admin/stories/top_bar'
  	@stories = Story.paginate(:all, :page => params[:page], :include => ['user', 'geocoding', 'view_counts'], :conditions => 'featured_at IS NOT NULL')
    render :template => 'admin/stories/featured'
  end

  
  
  def users
  	@map_javascript = true
		@users = User.paginate(:page => params[:page], :order => 'created_at DESC')
  	render :template => 'admin/users/index'
  end
    
  def stats
    
  end
  
  
  private

  def authorized?
  	return (logged_in? && current_user.has_role?('admin'))
  end
  
  def login_required
		redirect_to account_path unless authorized?
  end

end

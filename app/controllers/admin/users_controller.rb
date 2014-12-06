class Admin::UsersController < Admin::AdminController

	before_filter :get_user, :except => [ :index, :new, :create, :activate ]
	
	def index
	  @map_javascript = true
		@users = User.paginate(:page => params[:page],:include => [:geocoding], :order => 'created_at DESC')
   # abort @users.inspect
	end
	
	def show
    @stylesheet = [ 'modules/table_list' ]
		@stories = @user.stories.paginate(:all, :page => params[:page], :include => [:geocoding, :view_counts], :order => 'created_at desc')
	end
	
	def edit
	end  
  
  def update
    if @user.update_attributes(params[:user])
      redirect_to admin_user_path(@user)
    else
      setup_stylesheet
      render :action => "edit"
    end
  end
    
  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  private
  
	def get_user
		@user = User.find_by_login(params[:id])
	end  
      
  
end
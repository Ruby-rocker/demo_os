class UsersController < ApplicationController

	before_filter :get_user, :except => [ :index, :new, :create, :activate ]
	before_filter :login_required, :only => [ :edit, :update, :destroy ]
	before_filter :setup_stylesheet, :except => [ :create, :update, :destroy, :activate ]

	def show
	
  	unless @user == current_user || current_user.has_role?("admin")
	 	  redirect_to search_query_path('author', params[:login]) 
	 	  return false
  	end
  	  
	     	  
 	  @stylesheet.concat [ 'pages/account/main', 'modules/list' ]
		@stories = @user.stories.paginate(:all, :page => params[:page], :include => [ :user, :view_counts ], :order => 'created_at desc')
		@bookmarks = @user.bookmarks.paginate(:all, :page => params[:bpage], :joins => [ :story, :user ], :order => 'created_at desc')
	end
	

  def new
    @user = User.new
  end
  
	def edit
    @map_javascript = true
	end
 
 def edit_settings
 end
 
 
  def create
    #abort params[:user][:captcha].inspect

    @user = User.new(params[:user])
    @user.roles << Role.find_or_create_by_name('user')
    if simple_captcha_valid?
      success = @user && @user.save
      if success && @user.errors.empty?
        redirect_to root_path
        flash[:notice] = "Thanks for signing up! We're sending you an email with your activation code."
      else
        setup_stylesheet
        @stylesheet << 'pages/account/signup_login'      
        render :template => "static/account"
      end
    else
      flash[:notice] = "Please enter valid captcha."
      setup_stylesheet
      @stylesheet << 'pages/account/signup_login'      
      render :template => "static/account"
    end
  end
  
  
  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      if params[:user][:referring_url]
        redirect_to params[:user][:referring_url]
      else
        redirect_to edit_user_path(@user)
      end
    else
      setup_stylesheet
      render :action => "edit"
    end
  end
  
  

	def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      self.current_user = user
      flash[:notice] = "Thanks for activating your account! You are now signed in."
      redirect_to user.link_path      
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end
  
  
  def destroy
    @user.destroy
    redirect_to users_url
  end

  private
    
	  def get_user
	  	@user = User.find_by_login(params[:login]) rescue nil
    	if @user.nil?
  	    redirect_to error_path("404")
  	    return false
  	  end
	  end  
      
    def setup_stylesheet
    	@stylesheet = [ 'pages/account/shared', 'modules/pagination' ]
    end
  
  
end
class BuzzsController < ApplicationController
  before_filter :defaults, :except => [:new, :create, :index]
  before_filter :login_required
  before_filter :setup_stylesheet, :only => [:index, :show]
  #protect_from_forgery :except => :create

  def index
    @buzzs = Buzz.find(:all, :conditions => "((to_user_id = #{current_user.id} and to_user_deleted is null) or (from_user_id = #{current_user.id} and from_user_deleted is null)) and created_at = (select max(x.created_at) from buzzs x where x.root_id = buzzs.root_id)", :order => 'created_at desc');
    @user = current_user
  end
  
  def show
    @selected = Buzz.find(params[:id])
    @buzztree = Buzz.find(:all, :conditions =>{:root_id => @selected.root_id}, :order => "created_at asc")
    @user = current_user
    @buzz = Buzz.new
    @buzz.from_user_id = current_user.id
    @buzz.root_id = @selected.root_id
    @buzz.subject = @selected.root.subject
    @buzz.to_user_id = (@selected.root.from_user_id == current_user.id) ? @selected.root.to_user_id : @selected.root.from_user_id
  end
  
  def new
    @buzz = Buzz.new
    @buzz.from_user_id = current_user.id
    respond_to do |format|
      format.html {render :layout => false }
    end
  end
  
  def create
    @buzz = Buzz.new(params[:buzz])
    flash[:notice] = ''
    if @buzz.save
      #should be after create in model
      @buzz.update_attributes(:root_id => @buzz.id) if @buzz.root_id.nil?
      if @buzz.to.buzz_me_mail? 
        begin
          Notifier.deliver_buzz_received(@buzz)
        rescue
          #email failures doesn't stop delivery of buzz.
        end
      end
      flash[:notice] = '<b>Your buzz has been sent!'
    else
      flash[:notice] = 'Your buzz was not sent.<br/>Sorry.'
    end
    redirect_to @buzz.referring_url
  end

  def update
  end
  
  def destroy          
    #put in model at some point
    if @buzz.to == current_user
      Buzz.update_all("to_user_deleted = #{true}", "root_id = #{@buzz.root_id}")
    else
      Buzz.update_all("from_user_deleted = #{true}", "root_id = #{@buzz.root_id}")
    end
    #check if all have been deleted by both
    #@buzz.destroy
    redirect_to buzzs_path
  end

  def defaults
    @buzz = Buzz.find(params[:id])
  end
  
  def authorized?
    #if action_name == 'new' || action_name == 'create' || action_name == 'index' || action_name == 'destroy'
      logged_in?
    #else
    #  logged_in? && (@parent.user ? @parent.user == current_user : false)
    #end
  end
  
  def setup_stylesheet
  	@stylesheet = [ 'pages/account/shared', 'modules/pagination', 'pages/account/buzz' ]
  end

  
end
  

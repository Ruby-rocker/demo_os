class StoriesController < ApplicationController

  #include AdminHelper

	before_filter :setup_defaults, :except => [ :index, :map, :feature, :unfeature, :get_by_location, :unpublished ]
	before_filter :login_required, :except => [ :index, :map, :show, :get_by_location, :unpublished, :story_like, :slideshow, :show_all ]
	protect_from_forgery :except => :get_locations
	
	after_filter :record_view_count, :only => :show
		
	def index
	  
    # unless params[:ids] && !params[:ids].empty?
  	#   render :nothing => true
	  #   return false
	  # end
	  # @stories = Story.live.find(:all, :conditions => { :id => params[:ids] })
	  # # @story_loc = Story.find(params[:ids])
   # #  @find_all_story = Story.find_all_by_location(@story_loc.location).map{|a| a.id}.join(',')
   #    @story_loc = Story.find_by_sql("SELECT *  FROM stories WHERE id IN (#{params[:ids]})")
   #    @find_all_story = Story.find_all_by_location(@story_loc.map{|b| b.location}).map {|a| a.id}.join(',')
	  @stories = Story.find_by_sql("
      SELECT stories.id, stories.title, stories.path, stories.anonymous, stories.created_at, users.login AS user_login, geocodes.query, geocodes.longitude, geocodes.latitude, COUNT(view_counts.id) AS count
      FROM stories
      INNER JOIN users ON stories.user_id = users.id
      INNER JOIN geocodings ON stories.id = geocodings.geocodable_id AND geocodings.geocodable_type = 'Story'
      INNER JOIN geocodes ON geocodings.geocode_id = geocodes.id
      LEFT OUTER JOIN view_counts ON view_counts.viewable_id = stories.id AND view_counts.viewable_type = 'Story'
      WHERE LOWER(REPLACE(geocodes.query, '\n','')) LIKE '%#{params[:ids].to_s.downcase}%' AND geocodes.query != 'n/a' AND stories.published = true AND geocodings.geocodable_type = 'Story'
      GROUP BY stories.id
      ORDER BY count DESC
    ")
    session[:story] = params[:ids]
    render :layout => false, :template => 'stories/get_by_location'
  end
		
	
	def get_by_location
 
    if params[:query]
      session[:stories] = Array.new
      @stories = Story.find_by_sql("
        SELECT stories.id, stories.title, stories.path, stories.anonymous, stories.created_at, users.login AS user_login, geocodes.query, geocodes.longitude, geocodes.latitude, COUNT(view_counts.id) AS count
        FROM stories
        INNER JOIN users ON stories.user_id = users.id
        INNER JOIN geocodings ON stories.id = geocodings.geocodable_id AND geocodings.geocodable_type = 'Story'
        INNER JOIN geocodes ON geocodings.geocode_id = geocodes.id
        LEFT OUTER JOIN view_counts ON view_counts.viewable_id = stories.id AND view_counts.viewable_type = 'Story'
        WHERE LOWER(REPLACE(geocodes.query, '\n','')) LIKE '%#{params[:query].to_s.downcase}%' AND geocodes.query != 'n/a' AND stories.published = 1 AND geocodings.geocodable_type = 'Story'
        GROUP BY stories.id
        ORDER BY count DESC
      ")
      
    else
      @stories = []
    end
    session[:story] = params[:query]
  	respond_to do |format|
		  format.html { render :layout => false }
		  format.json  { render :json =>  @stories.to_json }
	  end	
    
	end
	

	
	def map
    @map_javascript = true
    @stylesheet = [ 'pages/map', 'modules/locations' ]
	end
	
  def audio_record
    filename = params[:filename]

    audio = request.raw_post
    File.open(filename, 'w+b'){|file| file.puts audio}

    respond_to do | format |
      format.json { render :json => { :status => 202 } }
    end
  end

  def slideshow
 #abort session[:story].inspect
    @stories = Story.find_by_sql("
        SELECT stories.id, stories.title, stories.path, stories.anonymous, stories.created_at, users.login AS user_login, geocodes.query, geocodes.longitude, geocodes.latitude, COUNT(view_counts.id) AS count
        FROM stories
        INNER JOIN users ON stories.user_id = users.id
        INNER JOIN geocodings ON stories.id = geocodings.geocodable_id AND geocodings.geocodable_type = 'Story'
        INNER JOIN geocodes ON geocodings.geocode_id = geocodes.id
        LEFT OUTER JOIN view_counts ON view_counts.viewable_id = stories.id AND view_counts.viewable_type = 'Story'
        WHERE LOWER(geocodes.query) LIKE '%#{session[:story].to_s.downcase}%' AND geocodes.query != 'n/a' AND stories.published = 1 AND geocodings.geocodable_type = 'Story'
        GROUP BY stories.id
        ORDER BY count DESC
      ")
    @find_story = Array.new
    @stories.each do |a|
      @find_story = @find_story << a.id
    end
    
    
    unless @story_slide
      return redirect_to(search_query_path('keyword', params[:path]))
    end
 
    # hide this code when anonymous story not display on slideshow
    # if @story_slide.anonymous && request.fullpath != @story_slide.link_path
    #   return redirect_to(@story_slide.link_path)
    # end

    #start of conversation
    if current_user
      @buzz = Buzz.new
      @buzz.from_user_id = current_user.id
      @buzz.to_user_id = @story_slide.user.id
    end
    
    if @story_slide.published? || @story_slide.user == current_user
      @referral = Referral.new
      render :layout => 'story'
    else
      render :layout => 'story', :template => 'stories/unpublished'
    end
  end
	
  def show
   
    @stories = Story.find_by_sql("
        SELECT stories.id, stories.title, stories.path, stories.anonymous, stories.created_at, users.login AS user_login, geocodes.query, geocodes.longitude, geocodes.latitude, COUNT(view_counts.id) AS count
        FROM stories
        INNER JOIN users ON stories.user_id = users.id
        INNER JOIN geocodings ON stories.id = geocodings.geocodable_id AND geocodings.geocodable_type = 'Story'
        INNER JOIN geocodes ON geocodings.geocode_id = geocodes.id
        LEFT OUTER JOIN view_counts ON view_counts.viewable_id = stories.id AND view_counts.viewable_type = 'Story'
        WHERE LOWER(geocodes.query) LIKE '%#{session[:story].to_s.downcase}%' AND geocodes.query != 'n/a' AND stories.published = 1 AND geocodings.geocodable_type = 'Story'
        GROUP BY stories.id
        ORDER BY count DESC
      ")
    @find_story = Array.new
    @stories.each do |a|
      @find_story << a.id
    end

    #unless @story_slide
      #return redirect_to(search_query_path('keyword', params[:path]))
    #end
    #abort @story_slide.inspect
    unless @story
      return redirect_to(search_query_path('keyword', params[:path]))
    end
    
    if @story.anonymous && request.fullpath != @story.link_path
      return redirect_to(@story.link_path)
    end

    #start of conversation
    if current_user
      @buzz = Buzz.new
      @buzz.from_user_id = current_user.id
      @buzz.to_user_id = @story.user.id
    end
    
    if @story.published? || @story.user == current_user
      @referral = Referral.new
      render :layout => 'story'
    else
      render :layout => 'story', :template => 'stories/unpublished'
    end
  end

  def show_all
    @stories = Story.find_by_sql("
        SELECT stories.id, stories.title, stories.path, stories.anonymous, stories.created_at, users.login AS user_login, geocodes.query, geocodes.longitude, geocodes.latitude, COUNT(view_counts.id) AS count
        FROM stories
        INNER JOIN users ON stories.user_id = users.id
        INNER JOIN geocodings ON stories.id = geocodings.geocodable_id AND geocodings.geocodable_type = 'Story'
        INNER JOIN geocodes ON geocodings.geocode_id = geocodes.id
        LEFT OUTER JOIN view_counts ON view_counts.viewable_id = stories.id AND view_counts.viewable_type = 'Story'
        WHERE LOWER(geocodes.query) LIKE '%#{session[:story].to_s.downcase}%' AND geocodes.query != 'n/a' AND stories.published = 1 AND geocodings.geocodable_type = 'Story'
        GROUP BY stories.id
        ORDER BY count DESC
      ")
    
    @find_story = Array.new
    @stories.each do |a|
      @find_story = @find_story << a.id
    end

    #unless @story_slide
      #return redirect_to(search_query_path('keyword', params[:path]))
    #end
    #abort @story_slide.inspect
    unless @story
      return redirect_to(search_query_path('keyword', params[:path]))
    end
    
    if @story.anonymous && request.fullpath != @story.link_path
      return redirect_to(@story.link_path)
    end

    #start of conversation
    if current_user
      @buzz = Buzz.new
      @buzz.from_user_id = current_user.id
      @buzz.to_user_id = @story.user.id
    end
    
    if @story.published? || @story.user == current_user
      @referral = Referral.new
      render :layout => 'story'
    else
      render :layout => 'story', :template => 'stories/unpublished'
    end
  end


  def unpublished
    render :layout => 'story'
  end


  def new
  	@stylesheet = [ 'pages/account/shared', 'pages/account/story' ]
  	@javascript = [ 'libs/autogrow', 'libs/autofieldset']
  end


  def edit
  	@stylesheet = [ 'pages/account/shared', 'pages/account/story' ]
  	@javascript = [ 'libs/autogrow', 'libs/autofieldset', 'libs/preview', 'libs/netstatus', 'libs/slider', 'libs/alert' ]
  	
  #	@story.paragraphs.push @story.paragraphs.new if @story.paragraphs.empty? || !@story.paragraphs.last.is_empty?
  end
  
  
  def create
    if @story.valid?
      @story.save
     # @story.paragraphs = params[:paragraphs]
    #  @story.paragraphs_new = params[:paragraphs_new]
	    redirect_to @user.link_path
    else
      rescue_invalid_story
      render :action => 'new'
    end
  end


  def update
  	if @story.update_attributes(params[:story])
    #  @story.paragraphs = params[:paragraphs]
    #  @story.paragraphs_new = params[:paragraphs_new]
      redirect_to @user.link_path
    else
      rescue_invalid_story
      render :action => "edit"
  	end    
  end


  def destroy
    @story.destroy
    redirect_to @user.link_path
  end
  
  def story_like
    story = Story.find(params[:id])
    if current_user
      if current_user.likes.find_by_story_id(story.id)
        current_user.likes.find_by_story_id(story.id).destroy
      else
        like = Like.new
        like.user = current_user
        like.story_id = story.id
        like.save!
      end
    else
      flash[:notice] = "Sorry, you must be logged in to use this feature."
    end
    redirect_to story.link_path
  end

  private
  
  def authorized?
    logged_in? || (logged_in? && current_user.has_role?("admin"))
  end
  
  def rescue_invalid_story
    #@paragraphs = []
    #@paragraphs.concat params[:paragraphs].collect{ |arr| Paragraph.exists?(arr[0]) ? Paragraph.find(arr[0]) : @story.paragraphs.build(arr[1]) } if params[:paragraphs]
    #@paragraphs.concat params[:paragraphs_new].collect{|arr| @story.paragraphs.build(arr[1]) } if params[:paragraphs_new] && !params[:paragraphs_new].empty?
    #@paragraphs << @story.paragraphs.build
    @javascript = [ 'libs/autogrow', 'libs/autofieldset' ]
    @stylesheet = [ 'pages/account/shared', 'pages/account/story' ]	
  end
  
  def setup_defaults
  	if params[:login]
	  	@user = User.find_by_login(params[:login])
	  #	@paragraphs = []
	  	if @user
  	  	case action_name
  	  		when 'new'
  	  			@story = @user.stories.build
  	  		#	@paragraphs << @story.paragraphs.build
  	  		when 'create'
  	  			@story = @user.stories.build(params[:story])
  	  		else
  	  			@story = @user.stories.find_by_path(params[:path]) rescue nil
  	  	end	  	
  	  else
    	  redirect_to search_query_path('author', params[:login])
    	end
  	else
      @story_slide = Story.find(:first, :conditions => { :id => params[:id] })
  		@story = Story.find(:first, :conditions => { :path => params[:path], :anonymous => '1' })
	  	@user = @story.user if @story
      #redirect_to unless @story
  	end
  end

	def record_view_count
		@story.record_view_count(request.remote_ip, logged_in?) if @story
	end
	
end
class StaticController < ApplicationController

  before_filter :login_from_cookie
  
  def index
  	@user = User.new
  	
  	@stylesheet = [ 'pages/home/browse','pages/home/content','pages/home/map','pages/home/png','modules/locations' ]
  	@map_javascript = true
  	@javascript = [ 'libs/netstatus','libs/toggler','libs/mininav','libs/quicksort', 'libs/slideshow' ]
    @slides = Dir.new("#{RAILS_ROOT}/public/images/pages/home/slideshow").entries.find_all{|item| item =~ /[a-zA-Z0-9\s_-]+\.(jpg|JPG)/ } #|| []
  	@feature_story = Story.find(:first, :include => [:user], :conditions => ["featured_at IS NOT NULL AND published = ?", true], :order => "featured_at desc")
  	@recent_story = Story.find(:last, :include => [:user, :geocoding], :conditions => { :published => true })
    @total_stories = Story.find(:all, :include => [:user, :geocoding], :conditions => { :published => true })
    # @stories_loc = Story.find(:all, :conditions => "published = 1").sort{ |first,second| first.title.downcase <=> second.title.downcase }.collect{ |s| s.title }  	
    @stories_loc = Story.find_by_sql("SELECT *  FROM stories s inner join geocodings g  on s.id=g.geocodable_id WHERE g.geocodable_type LIKE 'Story'").sort{ |first,second| first.title.downcase <=> second.title.downcase }.collect{ |s| s.title }
    @tags = Story.tag_counts(:limit => 250).sort { |a,b| a.name.downcase <=> b.name.downcase }
  	@locations = Geocode.find_by_sql("
  		select geocodes.query, COUNT(geocodings.id) as count
			from geocodes
			inner join geocodings on geocodes.id = geocodings.geocode_id and geocodings.geocodable_type = 'Story'
			where geocodes.query != 'n/a'
			group by geocodes.query
			limit 250
		")
		#@feature = Story.find(:last, :conditions => { :published => 1 }) || nil
  end

  def sorting_with_keyword
    character = params[:with].try(:downcase)
    ary = []
    if params[:with] == 'All'
      Story.all.each do |a|
        if a.published == true
          puts a.published
          ary << a.tags
        end
      end
      @tags = ary.flatten.uniq.compact.collect { |a| a.name.downcase }.sort { |a,b| a.downcase <=> b.downcase }
    else
      Story.all.each do |a|
        if a.published == true
          puts a.published
          ary << a.tags
        end
      end
      tags = ary.flatten.uniq.compact.collect { |a| a.name.downcase }
      @tags = tags.select { |val| val.match /^#{character}/ }
#     @tags = tags.select{|item| tags.count(item) > 1}.uniq
    end
  end 
  
  def privacy
    @stylesheet = 'pages/legal'
    render :layout => 'popup'
  end
  
  def terms
    @stylesheet = 'pages/legal'	
    render :layout => 'popup'
  end
  
  def account
  	redirect_to current_user.link_path if logged_in?
  	@user = User.new  	
  	@stylesheet = 'pages/account/signup_login'
  end
  
  
  def sitemap  
    @stylesheet = 'pages/sitemap'	
  end
  
  
  def error
  end

  def ourstory
    
  end
  
end

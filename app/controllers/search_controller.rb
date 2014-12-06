class SearchController < ApplicationController

  def new
  end

  def index
    @tags = Story.tag_counts(:limit => 250)
    @find_locations = Geocode.find_by_sql("
      select geocodes.query, COUNT(geocodings.id) as count
      from geocodes
      inner join geocodings on geocodes.id = geocodings.geocode_id and geocodings.geocodable_type = 'Story'
      where geocodes.query != 'n/a'
      group by geocodes.query
      limit 250
    ")
    @stories_loc = Story.find(:all, :conditions => "published = 1").sort{ |first,second| first.title.downcase <=> second.title.downcase }.collect{ |s| s.title }
    
    setup_layout
    
    @queries = []
    #@search_types = [ 'fiction', 'keyword', 'keywords', 'subject', 'author', 'location', 'date' ]
    @search_types = [ 'keyword', 'keywords', 'subject', 'author', 'location', 'date' ]
    
    order_by = "title"
    
    if params[:sort]
      case params[:sort]
        when "alphabetically"
           order_by = "stories.title"
        when "popularity"
           #order_by = "story_view_count"
        when "date"
           order_by = "stories.created_at"
      end
    end
    
    direction = params[:direction] && params[:direction].match(/asc|desc/) ? params[:direction] : "asc"
    search_type = params[:search_type] && @search_types.include?(params[:search_type].strip) ? params.delete(:search_type).strip : nil
    
    @queries << [search_type, params[:query]] if search_type && params[:query]
    @search_types.each do |t|
      @queries << [t, params[t]] if params[t] && !params[t].empty?
    end


    #query = params.delete(:query).strip
    conditions = []
    page = params[:page] ? params[:page].to_i : 1
    ids = []

    #ids << Tag.find(:all, :conditions => [ "name LIKE ?" , "test" ])
    
    puts @queries
    
    @queries.each do |t|
      type,query = t[0], (t[1] || "").gsub(/\'/, '\'').gsub(/\"/, '\"').downcase
      unless !query || query.empty?
        case type

          when 'keyword', 'keywords', 'subject'
            
            if query == "list_all_stories"
              ids << Story.find(:all).collect{|s|s.id}
            else
              words = query.split(/\s|\,|\+/).reject{|word| word.length < 3 }
              words << query
              
              tags = Tag.find(
                :all,
                :select => 'id',
                :conditions => "lower(name) IN (#{sql_array(words).join(", ")})"
              )
              ids << Tagging.find(:all, :conditions => { :tag_id => tags.collect{|t|t.id}, :taggable_type => 'Story' }).collect{ |tag| tag.taggable_id }
              
              c = []
              words.each do |w|
                word = w.strip.gsub(/\'/, '\'')
                c << "lower(title) LIKE '%#{word}%'"
                c << "(subject IS NOT NULL AND lower(subject) LIKE '%#{word}%')"
              end
              
              ids << Story.live.find(:all, :conditions => c.join(" OR ")).collect{|s|s.id}
          end
                        
          when 'author'
            names = sql_array(query.gsub(/\s\(/, ' ').gsub(/\)$/, '').split(' '))
            if query == 'anonymous'
              ids << Story.live.anonymous.collect{ |story| story.id }
            else
              users = User.find(
                :all,
                :select => 'id',
                :conditions => "lower(login) LIKE '#{query}' OR lower(email) LIKE '#{query}' OR (name IS NOT NULL AND lower(name) LIKE '%#{query}%')"
              )
              ids << Story.live.find(:all, :conditions => { :anonymous => false, :user_id => users.collect{|u|u.id} }).collect{ |story| story.id }
            end
                       
            
          when 'location'
          
          
            locations = sql_array(query.split(","))
            geocodes = Geocode.find(
              :all,
              :select => 'id',
              :conditions => [
                "lower(query) LIKE '%#{query}%'",
                "lower(locality) IN (#{locations.join(", ")})",
                "lower(region) IN (#{locations.join(", ")})",
                "lower(country) IN (#{locations.join(", ")})"
              ].join(" OR ")
            )
            geocodes = geocodes.collect{|g| g.id }.flatten.uniq
            unless geocodes.empty?
              geocode_ids = Geocoding.find(:all,
                :select => 'geocodable_id AS id',
                :conditions => "geocode_id IN (#{geocodes.join(',')}) AND (geocodable_type = 'Story' OR geocodable_type = 'User')"
                
                #{
                #  :geocode_id => geocodes,
                #  :geocodable_type => 'Story'
                #}  
              ).collect{|g| g.id }.flatten.uniq
              ids << geocode_ids
            end    
            
               
          when 'date'
            date = Date.parse(query.gsub(/[\.\-]/, '/')) rescue nil
            logger.info 'DATE!'
            logger.info date
            ids << Story.live.find(:all, :select => "id", :conditions => "year(stories.created_at) = #{date.year} AND month(stories.created_at) = #{date.month} AND day(stories.created_at) = #{date.day}" ).collect{|s|s.id} if date
          #when 'fiction'  
            #if query == 'unspecified'
              #conditions << "stories.fiction IS NULL"
            #else 
              #conditions << "stories.fiction = #{query == 'fiction' ? 1 : 0}"
            #end 
        end
      end
    end
    
    
    
    ids = ids.flatten.uniq.sort
    
    
    logger.info '------------------'
    logger.info ids
    logger.info ids.length
    logger.info '------------------'

    unless ids.empty?
      conditions << "stories.id IN (#{ids.join(',')})"
      @find_story_view = Story.find(:all,:conditions => conditions.join("AND"))
      @find_view_counts = @find_story_view.each.map{|b| b.view_counts}
      if @find_view_counts.flatten.blank?
        @stories = Story.live.paginate(
          :all,
          #:select => "*, count(id) as story_view_count"m #,# (SELECT COUNT(view_counts.id) FROM view_counts WHERE view_counts.viewable_id = stories.id AND view_counts.viewable_type = 'Story') as story_view_count2",# (SELECT COUNT(view_counts.id) FROM view_counts WHERE view_counts.viewable_id = stories.id AND view_counts.viewable_type = 'Story') as story_view_count",
          :page => page,
          :include => [:tags, :user, :geocoding, :view_counts, :bookmarks ],
          :order => "#{order_by} #{direction}",
          :conditions => conditions.join(" AND ")
        )
      else
        @stories = Story.live.paginate(
            :all,
            #:select => "*, count(id) as story_view_count"m #,# (SELECT COUNT(view_counts.id) FROM view_counts WHERE view_counts.viewable_id = stories.id AND view_counts.viewable_type = 'Story') as story_view_count2",# (SELECT COUNT(view_counts.id) FROM view_counts WHERE view_counts.viewable_id = stories.id AND view_counts.viewable_type = 'Story') as story_view_count",
            :page => page,
            :include => [:tags, :user, :geocoding, :view_counts, :bookmarks ],
            :order => "#{order_by} #{direction}",
            :conditions => conditions.join(" AND ")
        )
        #@stories = Story.live.paginate(
        #    :all,
        #    :select => "*,count(*) as my_count",
        #    #:select => "*, count(id) as story_view_count"m #,# (SELECT COUNT(view_counts.id) FROM view_counts WHERE view_counts.viewable_id = stories.id AND view_counts.viewable_type = 'Story') as story_view_count2",# (SELECT COUNT(view_counts.id) FROM view_counts WHERE view_counts.viewable_id = stories.id AND view_counts.viewable_type = 'Story') as story_view_count",
        #    :page => page,
        #    # :include => [:tags, :user, :geocoding, :view_counts, :bookmarks ],
        #    :joins => :view_counts,
        #    :group => "view_counts.viewable_id",
        #    :order => "my_count #{direction}",
        #    :conditions => conditions.join(" AND ")
        #)
      end
      story_list = Story.find(:all, :conditions => ["title IN (?)",@stories.collect{|a| a.title}])
      @locations = Geocoding.find(:all, :include => :geocode, :conditions => { :geocodable_id => story_list.collect{|s|s.id}, :geocodable_type => 'Story' }).group_by{ |location| location.geocode_id }
      #@locations = Geocoding.find(:all, :include => :geocode, :conditions => { :geocodable_id => @stories.collect{|s|s.id}, :geocodable_type => 'Story' }).group_by{ |location| location.geocode_id }
    else

      @stories = Story.live.paginate(:conditions => 'created_at IS NULL', :page => 1)
      @locations = []

    end

    
    #@stories = Story.paginate_by_queries(@queries, :page => params[:page], :order => "#{order_by} #{direction}")
    
    #if @stories.empty? && (0 < page)
    #  params.delete(:controller)
    #  params.delete(:action) 
    #  if page == 2
    #    params.delete(:page)
    #  else
    #    params.merge(:page => page - 1)
    #  end
    #  redirect_to search_query_path(search_type, query, params)
    #  return
    #end
  end

  def advance_search
    @tags = Story.tag_counts(:limit => 250).sort { |a,b| a.name.downcase <=> b.name.downcase }
    @find_locations = Geocode.find_by_sql("
      select geocodes.query, COUNT(geocodings.id) as count
      from geocodes
      inner join geocodings on geocodes.id = geocodings.geocode_id and geocodings.geocodable_type = 'Story'
      where geocodes.query != 'n/a'
      group by geocodes.query
      limit 250
    ")
    @stories_loc = Story.find(:all, :conditions => "published = 1").sort{ |first,second| first.title.downcase <=> second.title.downcase }.collect{ |s| s.title }

     setup_layout

     @queries = []

     @search_types = [ 'hdn_keyword', 'hdn_gender','hdn_age', 'hdn_location', 'hdn_stories', 'hdn_day', 'hdn_month', 'hdn_year', 'hdn_atoz' ]

     order_by = "title"

    if params[:sort]
      case params[:sort]
        when "alphabetically"
           order_by = "stories.title"
        when "popularity"
           #order_by = "story_view_count"
        when "date"
           order_by = "stories.created_at"
      end
    end

    direction = params[:direction] && params[:direction].match(/asc|desc/) ? params[:direction] : "asc"
    search_type = params[:search_type] && @search_types.include?(params[:search_type].strip) ? params.delete(:search_type).strip : nil

    @queries << [search_type, params[:query]] if search_type && params[:query]
    @search_types.each do |t|
      @queries << [t, params[t]] if params[t] && !params[t].empty?
    end

    #query = params.delete(:query).strip
    conditions = []
    page = params[:page] ? params[:page].to_i : 1
    ids = []

    #rakshit code start adding variable
    ids_key = []
    ids_gender = []
    ids_age = []
    ids_story = []
    ids_location = []
    ids_date = []
    # end of adding varialbe in rakshit code


    #ids << Tag.find(:all, :conditions => [ "name LIKE ?" , "test" ])


    @queries.each do |t|
      type,query = t[0], (t[1] || "").gsub(/\'/, '\'').gsub(/\"/, '\"').downcase

      unless !query || query.empty?
        case type
          #Query for finding value from keyword search in filters tab
          when 'hdn_keyword', 'keywords', 'subject'

            if query == "list_all_stories"
              ids << Story.find(:all).collect{|s|s.id}
            else
              # words = query.split(/\s|\,|\+/).reject{|word| word.length < 3 }
              words = query.split(",")
              words << query

              tags = Tag.find(
                :all,
                :select => 'id',
                :conditions => "lower(name) IN (#{sql_array(words).join(", ")})"
              )
              ids_key << Tagging.find(:all, :conditions => { :tag_id => tags.collect{|t|t.id}, :taggable_type => 'Story' }).collect{ |tag| tag.taggable_id }

              c = []
              words.each do |w|
                word = w.strip.gsub(/\'/, '\'')
                c << "lower(title) LIKE '%#{word}%'"
                c << "(subject IS NOT NULL AND lower(subject) LIKE '%#{word}%')"
              end

              ids << Story.live.find(:all, :conditions => c.join(" OR ")).collect{|s|s.id}
          end
          #Query for finding value of gender with image in filters tab
          when 'hdn_gender'
            find_gender = params[:hdn_gender]
            if params[:hdn_gender] != "both"
              ids_gender << Story.live.find(:all, :conditions => "stories.gender LIKE '#{find_gender}%'").collect{ |g| g.id }
            else
              find_all = "male,female"
              all_gender = find_all.split(/\s|\,|\+/).reject{|word| word.length < 1 }
              all_gender.each do |find_gender|
                ids_gender << Story.live.find(:all, :conditions => "stories.gender LIKE '#{find_gender}%'").collect{ |g| g.id }
              end
            end
          #Query for finding value of age in between selected years in filters tab
          when 'hdn_age'
            ages = params[:hdn_age].split(/\s|\,|\+/).reject{|word| word.length < 1 }
            ages.each do |age|
              lower_age = age
              upper_age = age.to_i + 10
              ids_age << Story.find(:all, :conditions => "stories.age >= #{lower_age} AND stories.age < #{upper_age}").collect{|a| a.id}
              # ids_age << Story.live.find(:all, :select => 'id', :conditions => "stories.age >= #{lower_age} AND stories.age < #{upper_age}").collect{ |a| a.id }
            end

            #ages = sql_array(query.split(","))
            #ids_age << Story.live.find(:all, :select => 'id', :conditions => "stories.age >= #{lower_age} AND stories.age < #{upper_age}").collect{ |a| a.id }

          #Query for finding stories from database in filters tab
          when 'hdn_stories'
            # stories = params[:hdn_stories].split(/\s|\,|\+/).reject{|word| word.length < 1 }
            stories = params[:hdn_stories].split(",").reject(&:empty?)
            stories.each do |find_story|
              #story = sql_array(query.split(","))
              ids_story << Story.live.find(:all, :select => 'id', :conditions => "stories.title LIKE '%#{find_story}%'").collect{ |s| s.id }.flatten.uniq
            end
          #Query for finding location from database in filters tab
          when 'hdn_location'


            locations = sql_array(query.split(","))
            geocodes = Geocode.find(
              :all,
              :select => 'id',
              :conditions => [
                "lower(query) LIKE '%#{query}%'",
                "lower(locality) IN (#{locations.join(", ")})",
                "lower(region) IN (#{locations.join(", ")})",
                "lower(country) IN (#{locations.join(", ")})"
              ].join(" OR ")
            )
            geocodes = geocodes.collect{|g| g.id }.flatten.uniq
            unless geocodes.empty?
              geocode_ids = Geocoding.find(:all,
                :select => 'geocodable_id AS id',
                :conditions => "geocode_id IN (#{geocodes.join(',')}) AND (geocodable_type = 'Story' OR geocodable_type = 'User')"

                #{
                #  :geocode_id => geocodes,
                #  :geocodable_type => 'Story'
                #}
              ).collect{|g| g.id }.flatten.uniq
              ids_location << geocode_ids
            end

          #Query for finding date from database when story is created in filter tab
          when 'hdn_year'
          when 'hdn_month'
          when 'hdn_day'

            date_find = params[:hdn_year] + '-' + params[:hdn_month] + '-' + params[:hdn_day]
            full_date = Date.parse(date_find)
            ids_date << Story.live.find(:all, :select => 'id', :conditions => "DATE_FORMAT(stories.created_at, '%Y-%m-%d') = '#{full_date}'").collect{ |fd| fd.id }
        end
      end
    end

    ids = Story.find(:all, :conditions => "published = 1").collect{|s| s.id}

    if params[:hdn_keyword].presence
      ids = ids & ids_key.flatten
    end

    if params[:hdn_age].presence
      ids = ids & ids_age.flatten
    end

    if params[:hdn_gender].presence
      ids = ids & ids_gender.flatten
    end

    if params[:hdn_location].presence
      ids = ids & ids_location.flatten
    end

    if params[:hdn_stories].presence
      ids = ids & ids_story.flatten
    end

    if params[:hdn_year].presence || params[:hdn_month].presence || params[:hdn_day].presence
      ids = ids & ids_date.flatten
    end

    #ids = ids.flatten.uniq.sort


    logger.info '------------------'
    logger.info ids
    logger.info ids.length
    logger.info '------------------'

    unless ids.empty?
      if params[:sort] == "popularity"
        conditions << "stories.id IN (#{ids.join(',')})"
        @find_story_view = Story.find(:all,:conditions => conditions.join("AND"))
        @find_view_counts = @find_story_view.each.map{|b| b.view_counts}
        if @find_view_counts.flatten.blank?
          @stories = Story.live.paginate(
            :all,
            #:select => "*, count(id) as story_view_count"m #,# (SELECT COUNT(view_counts.id) FROM view_counts WHERE view_counts.viewable_id = stories.id AND view_counts.viewable_type = 'Story') as story_view_count2",# (SELECT COUNT(view_counts.id) FROM view_counts WHERE view_counts.viewable_id = stories.id AND view_counts.viewable_type = 'Story') as story_view_count",
            :page => page,
            :include => [:tags, :user, :geocoding, :view_counts, :bookmarks ],
            :order => "#{order_by} #{direction}",
            :conditions => conditions.join(" AND ")
          )
        else
          @stories = Story.live.paginate(
              :all,
              #:select => "*, count(id) as story_view_count"m #,# (SELECT COUNT(view_counts.id) FROM view_counts WHERE view_counts.viewable_id = stories.id AND view_counts.viewable_type = 'Story') as story_view_count2",# (SELECT COUNT(view_counts.id) FROM view_counts WHERE view_counts.viewable_id = stories.id AND view_counts.viewable_type = 'Story') as story_view_count",
              :page => page,
              :include => [:tags, :user, :geocoding, :view_counts, :bookmarks ],
              :order => "#{order_by} #{direction}",
              :conditions => conditions.join(" AND ")
          )
          #@stories = Story.live.paginate(
          #  :all,
          #  :select => "*,count(*) as my_count",
          #  #:select => "*, count(id) as story_view_count"m #,# (SELECT COUNT(view_counts.id) FROM view_counts WHERE view_counts.viewable_id = stories.id AND view_counts.viewable_type = 'Story') as story_view_count2",# (SELECT COUNT(view_counts.id) FROM view_counts WHERE view_counts.viewable_id = stories.id AND view_counts.viewable_type = 'Story') as story_view_count",
          #  :page => page,
          #  # :include => [:tags, :user, :geocoding, :view_counts, :bookmarks ],
          #  :joins => :view_counts,
          #  :group => "view_counts.viewable_id",
          #  :order => "my_count #{direction}",
          #  :conditions => conditions.join(" AND ")
          #)
        end
        story_list = Story.find(:all, :conditions => ["title IN (?)",@stories.collect{|a| a.title}])
        @locations = Geocoding.find(:all, :include => :geocode, :conditions => { :geocodable_id => story_list.collect{|s|s.id}, :geocodable_type => 'Story' }).group_by{ |location| location.geocode_id }
      else
        conditions << "stories.id IN (#{ids.join(',')})"

        @stories = Story.live.paginate(
          :all,
          #:select => "*, count(id) as story_view_count"m #,# (SELECT COUNT(view_counts.id) FROM view_counts WHERE view_counts.viewable_id = stories.id AND view_counts.viewable_type = 'Story') as story_view_count2",# (SELECT COUNT(view_counts.id) FROM view_counts WHERE view_counts.viewable_id = stories.id AND view_counts.viewable_type = 'Story') as story_view_count",
          :page => page,
          :include => [:tags, :user, :geocoding, :view_counts, :bookmarks ],
          :order => "#{order_by} #{direction}",
          :conditions => conditions.join(" AND ")
        )
        @locations = Geocoding.find(:all, :include => :geocode, :conditions => { :geocodable_id => @stories.collect{|s|s.id}, :geocodable_type => 'Story' }).group_by{ |location| location.geocode_id }
      end
      session[:story_id] = ids
    else

      @stories = Story.live.paginate(:conditions => 'created_at IS NULL', :page => 1)
      @locations = []

    end
  end

	private
	
	def sql_array(array)
	  array.to_a.collect{ |i| "'#{i.downcase.strip.gsub(/\'/, '\'')}'" }
	end
	
	
	def setup_layout
    @top_bar_partial = 'search/top_bar'
		@map_javascript = true
		@javascript = [ 'libs/toggler','libs/mininav','libs/quicksort','libs/slider']
		@stylesheet = [ 'pages/search/results', 'pages/search/nav', 'modules/pagination', 'modules/locations' ]
	end
end
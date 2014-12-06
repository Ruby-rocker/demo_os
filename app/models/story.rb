class Story < ActiveRecord::Base
  
  belongs_to :user
  #has_many   :paragraphs, :dependent => :destroy
  has_many   :assets, :as => :attachable, :dependent => :destroy
  #has_one    :paragraph_count, :class_name => 'Paragraph', :select => 'COUNT(id) as count', :readonly => true
  has_many :likes, :dependent => :destroy
  
  has_many   :bookmarks,  :dependent => :destroy
  has_attached_file :media
  acts_as_geocodable
  acts_as_taggable
  has_view_count
  
  validates_presence_of :title, :user_id, :year
  validates_presence_of :location, :unless => :use_author_location
  validates_presence_of :state, :unless => :use_author_location
  validates_presence_of :country, :unless => :use_author_location
  after_validation :create_path
  #validates_inclusion_of :fiction, :in => [true, false]
  
  cattr_reader :per_page
  @@per_page = 25
  
  named_scope :live, :conditions => { :published => true }
  named_scope :anonymous, :conditions => { :anonymous => true }
    
  def self.featured
    find(:first, :conditions => 'featured_at IS NOT NULL', :order => 'featured_at DESC')
  end

    
  def featured?
    self.featured_at != nil
  end
    
  def feature!
    return false if featured? || !published?
    self.featured_at = Time.now
    self.save!
  end
  
  def unfeature!
    return false unless self.featured_at
    self.featured_at = nil
    self.save!
  end
  
  
  def published?
    self.published == true
  end
  
  def publish!
    return false if published
    self.published = true
    self.save!
  end
  
  def unpublish!
    return false unless published
    self.published = false
    self.save!
  end
=begin   
  def paragraphs=(value)
    value.each do |paragraph_params| 
      id = paragraph_params[0] ? paragraph_params[0].to_i : 0 
      body = paragraph_params[1][:body] ||= ""
      asset = paragraph_params[1][:asset] ||= ""  
      paragraph = 0 < id && Paragraph.exists?(id) ? Paragraph.find(id) : self.paragraphs.new(:story => self)
      
      if (body.length + asset.length) == 0
        if paragraph && paragraph.id
          if paragraph.asset                   
            saved = paragraph.update_attributes(:body => body)
          else
            paragraph.destroy
          end
        end     
      else      
        if paragraph.id && asset.length == 0
          saved = paragraph.update_attributes(:body => body)
        else
          saved = paragraph.update_attributes(:body => body, :asset => asset)
        end
      end     
    end
  end
 
 
  def paragraphs_new=(value)
    unless !value || value.empty?
      value.each do |paragraph_params| 
        body = paragraph_params[1][:body] ||= ""
        asset = paragraph_params[1][:asset] ||= ""
        paragraph = self.paragraphs.create!(:body => body, :asset => asset) unless (body.length + asset.length) == 0
      end
    end
  end
=end  
    
  def create_path
    unless !self.title || self.title.empty?
      exists = nil
      count = 2
      new_path = self.title.downcase.gsub(/\s/, '_').gsub(/[^a-z0-9\_]/, '').gsub(/[\_]+/, '_')
      exists = path_exists_for_parent?(new_path)
      while exists do
        dupe_path = "#{new_path}_#{count}"
        exists = path_exists_for_parent?(dupe_path)
        count+=1
      end
      self.path = dupe_path || new_path
    end
    self.path
  end
    
  def path_exists_for_parent?(path)   
    if anonymous?
      story = Story.find(:first, :conditions => { :path => path, :anonymous => true })
      same_story = story == self
      path_exists = (story != nil && !same_story)
    else
      story = Story.find_by_path(path)
      same_user = story.user == self.user if story
      same_story = story == self
      path_exists = (story != nil && same_user && !same_story)
    end
    return path_exists
  end
  

  def author
    if anonymous?
      "anonymous" 
    else
      self.user.name.empty? ? "#{self.user.login}" : "#{self.user.name} (#{self.user.login})"
    end
  end
  
  def author_path
    anonymous? ? "/anonymous/" : "#{self.user.link_path}"
  end
  
  def author_location
    if anonymous? && !use_author_location?
      ""
    else
      self.user.location
    end
  end 
  
  
  def pin_location
    if use_author_location?
      loc = author_location
    else
      if !location || location.empty?
        loc = "n/a"
      else
        loc = ""
        loc += location if !location.nil?
        loc += ", " + state if !state.nil?
        loc += " " + country if !country.nil?
      end
    end
    loc || ''
  end
  
  
  def feature_month
    self.featured_at.strftime('%B %y')
  end
    
  
  def month
    self.created_at.strftime('%B %y')
  end
    
  def anonymous?
    self.anonymous == 1 || self.anonymous == true
  end
    
  def use_author_location?
    self.use_author_location == 1 || self.use_author_location == true
  end
  
  
  def location=(value)
    write_attribute :location, (value || "").gsub(/\s+/, ' ').strip
  end
  
  def to_location
    #return nil if anonymous? && !location.empty?
    #loc = use_author_location? ? author_location : location
    begin
      pin_location == 'n/a' ? nil : Geocode.geocoder.locate(pin_location)
    rescue => e
      Rails.logger.warn "Story Geolocation Failed:"
      Rails.logger.warn e.message
      nil
    end
  end
  
  
  def to_param
    "#{self.path}"
  end
  
  def link_path
    anonymous? ? "/anonymous/#{self.path}" : "#{self.user.link_path}/#{self.path}"
  end

  def bookmarked_by_user?(user)
    0 <= self.bookmarks.index_of(user)
  end

  def bookmark_count
    self.bookmarks.length
  end

  # FIND FUNCTIONS 
  
  def self.paginate_by_queries(queries, *args)
    options = standard_options(*args)
    options[:page] = options[:page] || 1
    conditions, or_conditions = [], []
    conditions << sanitize_sql(options.delete(:conditions)) if options[:conditions]
    queries.each do |t|
      type,query = t[0], (t[1] || "").gsub(/\'/, '\'').gsub(/\"/, '\"').downcase
      unless !query || query.empty?
        case type
          when 'keyword'
            conditions << "lower(tags.name) = '#{query}'"
          when 'keywords'
            words = query.split(/\s|\,|\+/).reject!{|word| word.length < 3 }.to_a
            or_conditions << "lower(tags.name) LIKE '%#{query}%'"
            words.each do |word|
              or_conditions << "lower(stories.title) LIKE '%#{word}%'"
              or_conditions << "lower(stories.subject) LIKE '%#{word}%'"
              or_conditions << "lower(tags.name) LIKE '%#{word}%'"
            end
          when 'author'
            names = query.gsub(/\s\(/, ' ').gsub(/\)$/, '').split(' ')
            if query == 'anonymous'
              conditions << "stories.anonymous = 1"
            else
              or_conditions << "(lower(users.login) LIKE '%#{query}%' OR lower(users.name) LIKE '%#{query}%')"
              names.each do |name|
                or_conditions << "(lower(users.login) LIKE '%#{name}%' OR lower(users.name) LIKE '%#{name}%')"
              end
              conditions << "stories.anonymous != 1"
            end
          when 'location'
            locations = query.split(/\s|\,/)
            or_conditions << "lower(stories.location) LIKE '%#{query}%' OR (lower(stories.author_location) LIKE '%#{query}%' AND stories.anonymous != 1) OR lower(geocodes.query) LIKE '%#{query}%' OR lower(geocodes.locality) LIKE '%#{query}%' OR lower(geocodes.region) LIKE '%#{query}%' OR lower(geocodes.country) LIKE '%#{query}%'"
            locations.each do |location|
              or_conditions << "lower(stories.location) LIKE '%#{location}%' OR (lower(stories.author_location) LIKE '%#{location}%' AND stories.anonymous != 1) OR lower(geocodes.query) LIKE '%#{location}%' OR lower(geocodes.locality) LIKE '%#{location}%' OR lower(geocodes.region) LIKE '%#{location}%' OR lower(geocodes.country) LIKE '%#{location}%'" if 1 < location.length
            end
          when 'date'
            query = Date.parse(query.gsub(/[\.\-]/, '/')) rescue nil
            conditions << "year(stories.created_at) = #{query.year} AND month(stories.created_at) = #{query.month} AND day(stories.created_at) = #{query.day}" if query
          #when 'type'
            #if query == 'unspecified'
              #conditions << "stories.fiction IS NULL"
            #else 
              #conditions << "stories.fiction = #{query == 'fiction' ? 1 : 0}"
            #end 
        end
      end
    end
    conditions << ["stories.published = ?", true]
    options[:conditions] = or_conditions.empty? ? sanitize_sql(conditions.join("\nAND ")) : sanitize_sql(conditions.join("\nAND ")) + " AND (" + sanitize_sql(or_conditions.join("\nOR ")) + ")"
    options.blank? ? [] : Story.paginate(:all, options)
  end


  def self.standard_options(*args)
    options = args[0]
    { #:select => [ "DISTINCT stories.*, (SELECT COUNT(view_counts.id) FROM view_counts WHERE view_counts.viewable_id = stories.id AND view_counts.viewable_type = 'Story') as story_view_count" ],
      :include => [ :user, :geocoding, :tags, :bookmarks, :view_counts ],
      :joins => standard_joins.join("\n")
    }.reverse_merge!(options)
  end
  
  
  def self.standard_joins
    [
      "\nINNER JOIN users ON stories.user_id = users.id",
      "INNER JOIN geocodings ON geocodings.geocodable_id = stories.#{primary_key} AND geocodings.geocodable_type = #{quote_value(base_class.name)}",
      "INNER JOIN geocodes ON geocodes.id = geocodings.geocode_id",
      "LEFT OUTER JOIN taggings ON stories.id = taggings.taggable_id AND taggings.taggable_type = 'Story'",
      "LEFT OUTER JOIN tags ON taggings.tag_id = tags.id"
    ]
  end
  
end

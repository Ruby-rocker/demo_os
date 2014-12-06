require 'digest/sha1'

class User < ActiveRecord::Base
  
  cattr_reader :per_page
  @@per_page = 25
    
	acts_as_geocodable

  has_many :stories,   :dependent => :destroy
  has_many :bookmarks, :dependent => :destroy
  has_many :assets,    :dependent => :destroy
  has_and_belongs_to_many :roles
  has_many :sent_buzzs, :foreign_key => 'from_user_id', :class_name => "Buzz"
  has_many :received_buzzs, :foreign_key => 'to_user_id', :class_name => "Buzz"
  has_many :likes, :dependent => :destroy
  
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  #validates_length_of       :name,     :maximum => 100

  validates_length_of       :city,     :maximum => 100
  validates_length_of       :state,    :maximum => 100
  validates_length_of       :country,  :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message
  
  validates_presence_of			:agreed
  
  validates_format_of       :dob,      :with => /^([\d]{2}\/){2}[\d]{4}$/, :message => "must be in mm/dd/yyyy", :allow_nil => true

  after_validation :check_login
  before_create :make_activation_code

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :agreed, :dob, :gender, :login, :email, :name, :city, :state, :ip_address, :country, :password, :password_confirmation, :buzz_me, :buzz_me_mail
  attr_accessor :referring_url

  # check login to ensure it won't conflict with named routes
  def check_login   
    if self.login && self.login.downcase.match(/(account|activate|admin|anonymous|contact|locations|login|logout|register|search|session|signup|sitemap|stories|users)/)
      self.errors.add(nil, "You may not use #{self.login} as your login, sorry!")
  	end
  end

	# checks roles
	def has_role?(role_in_question)
    @_list ||= self.roles.collect(&:name)
    return true if @_list.include?("admin")
    (@_list.include?(role_in_question.to_s) )
  end



  # Activates the user in the database.
  def activate!
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find :first, :conditions => ['login = ? and activated_at IS NOT NULL', login] # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end
  
  
  
  def forgot_password
    @forgotten_password = true
    self.make_password_reset_code
  end
  def reset_password
    # First update the password_reset_code before setting the 
    # reset_password flag to avoid duplicate email notifications.
    update_attribute(:password_reset_code, nil)
    @reset_password = true
  end  
  #used in user_observer
  def recently_forgot_password?
    @forgotten_password
  end
  def recently_reset_password?
    @reset_password
  end
  
  def self.find_for_forget(email)
    find :first, :conditions => ['email = ? and activated_at IS NOT NULL', email]
  end
  
  #setters
	def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end
	def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
	def dob=(value)
		val = Date.parse(value.gsub(/[\.\-]/, '/')) rescue nil unless value.nil?
		write_attribute :dob, val
	end
	
  def gender=(value)
		write_attribute :gender, (value ? ( value.strip.match(/^(male)$/i) ? 1 : 0 ) : nil)
	end
    
  def city=(value)
    write_attribute :city, value ? value.capitalize : nil
  end
  
  def state=(value)
    write_attribute :state, value ? value.capitalize : nil
  end
  
  def country=(value)
    write_attribute :country, value ? value.capitalize : nil
  end
  
  
  
  
	
	#getters
	def email_with_name
		"#{self.name} <#{self.email}>"
  end
  
  def link_path
		return "/#{self.login}"
  end
  
  def to_param
  	self.login
  end
  
  def first_role
  	"#{self.roles[0].name}" if self.roles[0]
  end
  
  
  def city
    if_available(:city)
  end
  
  def state
    if_available(:state)
  end
  
  def country
    if_available(:country)
  end
  
  
  def active?
    activation_code.nil?
  end
  
 
  def gender
		case read_attribute(:gender)
			when true
				"male"
			when false
				"female"
		  else
		    "unspecified"
		end
	end
	
 
	def location
	  loc = []
	  loc << self.city unless self.city.empty?
	  loc << self.state unless self.state.empty?
	  loc << self.country unless self.country.empty?
    loc.join(", ")
	end

	def to_location
		#location.empty? ? Graticule.service(:host_ip).new.locate(self.ip_address) : Geocode.geocoder.locate(location)
		begin
  		location && location != "n/a" ? Geocode.geocoder.locate(location) : 'n/a'
    rescue => e
      Rails.logger.warn "User Geolocation Failed:"
      Rails.logger.warn e.message
      nil
    end
	end

  protected
    
    def if_available(attribute)
      return read_attribute(attribute) && !read_attribute(attribute).empty? ? read_attribute(attribute) : ""#'n/a'
    end
    
    def make_activation_code
        self.activation_code = self.class.make_token
    end
  
    def make_password_reset_code
      self.password_reset_code = self.class.make_token
    end

end

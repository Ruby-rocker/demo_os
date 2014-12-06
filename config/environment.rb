# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.11' unless defined? RAILS_GEM_VERSION

require "bundler"
Bundler.setup

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')
	
SITE_URL = "http://onestoryroad.com"

# onestoryroad.com
MAP_KEY = "AIzaSyDu5zZLkwP1xU-Dj0i45igHeaEJB7sNW5w"
# osr.citrusme.com
STAGING_MAP_KEY = "ABQIAAAAGxiQgLdir3vMu28ihaCkNxRaCaan0yzuBhHgDNougCBOS1Y0WhSdUiaFOwYMmyLFPrLxQn5zE0DJJw"
Rails::Initializer.run do |config|
  
  config.active_record.observers = :user_observer
  config.active_record.default_timezone = :utc
  
  config.action_view.sanitized_allowed_attributes = ['style']

end

require 'graticule'
require 'will_paginate' 
require 'which_browser'

Geocode.geocoder = Graticule.service(:google).new MAP_KEY

ExceptionNotification::Notifier.exception_recipients = %w(khrystle@gmail.com)
ExceptionNotification::Notifier.sender_address = %("OSR ERROR" <system@onestoryroad.com>)
ExceptionNotification::Notifier.email_prefix = "OSR ERROR: "

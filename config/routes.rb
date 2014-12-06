ActionController::Routing::Routes.draw do |map|
  
  require 'jammit'
  Jammit::Routes.draw(map)

 map.sorting_with_keyword 'sorting_with_keyword', :controller => 'static', :action => 'sorting_with_keyword'

	map.namespace :admin do |admin|

 	  admin.resources :stories, 
 	    :member => { 
 	      :feature => :get,
 	      :unfeature => :get,
 	      :publish => :get,
 	      :unpublish => :get
 	    },
 	    :collection => {
 	      :featured => :get
 	    }
 	    
  	admin.resources :users, :requirements => { :id => /.*/ }
 	  admin.resources :stats, :only => :index
 	  admin.resources :banners
 	  admin.resources :uploads,
 	  	:collection => {
 	  		:cleanup => :get
 	  	}
 	  admin.uploadFile 'uploads', :controller => 'uploads', :action => "uploadFile"
 	  #admin.cleanup 'cleanup/:id', :controller => 'uploads', :action => "cleanup", :conditions => { :method => :get }
 	  admin.root :controller => 'home'
 	  
 	end

	map.simple_captcha '/simple_captcha/:action', :controller => 'simple_captcha'
  map.resources :assets
	map.resources :buzzs
	
  map.edit_settings  '/:login/edit-settings', :controller => 'users', :action => 'edit_settings', :conditions => { :method => :get }
  
  map.error '/error/:code', :controller => 'static', :action => 'error'
  

	#static
	map.connect '/:action', :controller => 'static', :requirements => { :action => /(index|terms|privacy|sitemap)/ }
	



  #worldwide locator
	map.map_stories '/stories/map', :controller => 'stories', :action => 'map', :conditions => { :method => :get }
	
  #stories
	map.stories_by_ids  '/stories/in/:ids', :controller => 'stories', :action => 'index'
  map.story_like '/story_like/:id', :controller => 'stories', :action => 'story_like', :conditions => { :method => :get }
	                    
	
  #search
	map.search_query '/search/:search_type/:query', :controller => 'search', :action => 'index'	
	map.new_search '/search/new', :controller => 'search', :action => 'new', :conditions => { :method => :get }	
	map.search '/search', :controller => 'search', :action => 'index'#, :conditions => { :method => :any }
	map.advance_search '/advance-search', :controller => 'search', :action => 'advance_search'
	

	
	#json routes
	map.geocodes '/geocodes.:format', :controller => 'geocodes'
	map.stories_by_location '/stories/near/location.:format', :controller => 'stories', :action => 'get_by_location'
	


	# user account
  map.save_new_password '/password/reset/:id', :controller => 'passwords', :action => 'update', :conditions => { :method => :post }
	map.reset_password '/password/reset/:id', :controller => 'passwords', :action => 'edit', :conditions => { :method => :get }
	map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/account', :controller => 'static', :action => 'account'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate'
  map.account '/account', :controller => 'static', :action => 'account'
  map.users '/users', :controller => 'users', :action => 'create', :conditions => { :method => :post }
  map.ourstory '/ourstory', :controller => 'static', :action => 'ourstory'
  
	
	#resources
  map.resource :password, :path_names => { :new => 'recover' }
  map.resource :referrals, :session
  map.resources :contacts, :as => 'contact'
  map.resources :reports, :as => 'report'
  
  
  
	#anonymous
  #map.anonymous_stories '/anonymous', :controller => 'stories', :action => 'index'
  map.anonymous_story '/anonymous/:path', :controller => 'stories', :action => 'show', :anonymous => true
  map.anonymous_story '/anonymous/:path', :controller => 'stories', :action => 'show_all', :anonymous => true
  map.unpublished_story '/unpublished', :controller => 'stories', :action => 'unpublished'
  map.slideshow_story '/slideshow/:id', :controller => 'stories', :action => 'slideshow', :anonymous => true
  map.audio_record 'audio_record', :controller => "stories", :action => 'audio_record'
	
	# profile
	map.edit_user       '/:login/edit', :controller => 'users', :action => 'edit', :conditions => { :method => :get }
	map.user            '/:login',      :controller => 'users', :action => 'update', :conditions => { :method => :put }
	map.user            '/:login',      :controller => 'users', :action => 'show', :conditions => { :method => :get }
	
	
	map.new_story       '/:login/stories/new', :controller => 'stories', :action => 'new', :conditions => { :method => :get }
	map.edit_story      '/:login/:path/edit',  :controller => 'stories', :action => 'edit', :conditions => { :method => :get }
	map.delete_story      '/:login/:path/delete',  :controller => 'stories', :action => 'destroy', :conditions => { :method => :delete }
	map.user_stories    '/:login/stories',     :controller => 'stories', :action => 'create', :conditions => { :method => :post }
	map.story           '/:login/:path',       :controller => 'stories', :action => 'show', :conditions => { :method => :get }
	map.story_all       'show_all/:login/:path',:controller => 'stories', :action => 'show_all', :conditions => { :method => :get }

  map.story_photo     '/:login/:path/photos/:id', :controller => 'assets', :action => 'destroy', :conditions => { :method => :delete }
	                    
	map.user_story      '/:login/:path', :controller => 'stories', :action => 'update', :conditions => { :method => :put }#, :requirements => { :path => /.+/ }
	map.user_story      '/:login/:path', :controller => 'stories', :action => 'destroy', :conditions => { :method => :delete }#, :requirements => { :path => /.+/ }
	
	map.bookmark_story  '/:login/:path/bookmark',      :controller => 'bookmarks', :action => 'create', :conditions => { :method => :post }
	map.delete_bookmark '/:login/bookmarks/:bookmark', :controller => 'bookmarks', :action => 'destroy', :conditions => { :method => :delete }
	
	
	
	
	
	
	
	#root
  map.root :controller => 'static'
  
end

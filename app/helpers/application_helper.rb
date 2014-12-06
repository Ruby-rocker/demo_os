module ApplicationHelper
	
	include TagsHelper
	
	def is_empty_or_nil?(arr=nil)
		return arr.nil? || arr.empty?
	end
	
  def image_title(image,text)
    "<h1 class=\"image\" style=\"background-image: url(/images/#{image});\">#{text}</h1>"
  end
  
	def flash_notice
    err = flash[:notice] || flash[:error]
    cls = "notice" if flash[:notice]
    cls = "error" if flash[:error]
    flash[:notice] = flash[:error] = nil
    if params[:controller] == "stories" && (params[:action] == "show" || params[:action] == "slideshow")
      "<div id=\"flashBox\"><div id=\"flashOverlay\">&nbsp;</div><div id=\"flash\" class=\"#{cls}\">#{simple_format err}<span></br><a href=\"#{current_path}\" onclick=\"document.getElementById('flashBox').style.display = 'none'; return false;\" class=\"button\">close</a></span><span style ='margin-left:20px;'><a href=\"#{account_path}\" onclick=\"document.getElementById('flashBox').style.display = 'none';window.opener.location='/account';window.close(); return true;\" class=\"button\">Sign Up</a></span></div></div>" if err
    else      
      "<div id=\"flashBox\"><div id=\"flashOverlay\">&nbsp;</div><div id=\"flash\" class=\"#{cls}\">#{simple_format err}<p></br><a href=\"#{current_path}\" onclick=\"document.getElementById('flashBox').style.display = 'none'; return false;\" class=\"button\">close</a></p></div></div>" if err
    end      
  end
  
  def flash_banner
    @banner = Banner.where('status = ?', true).order('sort ASC').all
    return @banner
  end
  
  def feature_story_path
    feat = Story.featured rescue nil
    feat ? story_path(feat.user, feat) : nil    
  end

  def use_tinymce
    str = javascript_include_tag "tiny_mce/tiny_mce"
    str += javascript_include_tag "mce_editor"
    str
  end
  
  def round(val)
   
    if (val)
      matches = val.to_s.match(/[\d]+[\.]([\d]{0,4})/)
      val = matches ? matches[0] : nil
    end 
    val
  end
  
  
  def current_path
    return request.request_uri
  end

	def nav_style(path)
		"background-color: #303030;" if path.gsub(/\/$/, '') == current_path.gsub(/\/$/, '')
	end

  def count_string(count=0, title='items', link=false)
		"#{'view ' if link}#{count} #{ count == 1 ? title.singularize : (link ? 'all ' : '') + title.pluralize }"
  end
  
  def list_color(count=0)
    return "gray" if count % 2 == 0
  end
  
  
  def api_key(env=RAILS_ENV)
    ENV["GOOGLE_MAP_API_KEY"] || (request.host == "osr.citrusme.com" ? STAGING_MAP_KEY : MAP_KEY)
  end
  
  def share_with_facebook_url(opts)

    # Generates an url that will 'share with Facebook', and can includes title, url, summary, images without need of OG data.
    #
    # URL generate will be like
    # http://www.facebook.com/sharer.php?s=100&p[title]=We also do cookies&p[url]=http://www.wealsodocookies.com&p[images][0]=http://www.wealsodocookies.com/images/logo.jpg&p[summary]=Super developer company
    #
    # For this you'll need to pass the options as
    #
    # { :url     => "http://www.wealsodocookies.com",
    #   :title   => "We also do cookies",
    #   :images  => {0 => "http://imagelink"} # You can have multiple images here
    #   :summary => "My summary here"
    # }

    url = "http://www.facebook.com/sharer/sharer.php?s=100"

    parameters = []

    opts.each do |k,v|
      key = "p[#{k}]"

      if v.is_a? Hash
        v.each do |sk, sv|
          parameters << "#{key}[#{sk}]=#{sv}"
        end
      else
        parameters << "#{key}=#{v}"
      end

    end

    url + parameters.join("&")
  end


end

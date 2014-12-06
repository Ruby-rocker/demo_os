class ApplicationController < ActionController::Base

  include AuthenticatedSystem
  include RoleRequirementSystem
  include SimpleCaptcha::ControllerHelpers

  helper :all
  protect_from_forgery
  
  private 
  
  #helper_method :debug
  
  #after_filter :write_debug
  
  def authorized?(action = action_name, resource = nil)
    logged_in? && (@user ? @user == current_user : false)
  end
  
  def mobile_device?
    request.user_agent =~ /Mobile|webOS/
  end
  helper_method :mobile_device?
  
  #def debug(message)
  #  @message = message
  #end
  #
  #def write_debug
  #  @message ||= ""
  #  puts "\n\n\n\n#{@message}\n\n\n\n"
  #end
  
end

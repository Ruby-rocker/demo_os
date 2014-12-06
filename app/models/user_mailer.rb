class UserMailer < ActionMailer::Base

  def signup_notification(user)
    setup_email(user)
    @subject += 'Please activate your new account'
    @body[:url] = "#{SITE_URL}/activate/#{user.activation_code}"
  end
  
  def activation(user)
    setup_email(user)
    @subject += 'Your account has been activated!'
    @body[:url]  = "#{SITE_URL}/account"
  end
  
  
  def forgot_password(user)
    setup_email(user)
    @subject += 'Forgot password'
    @body[:url] = "#{SITE_URL}#{reset_password_path(user.password_reset_code)}"
  end
  
  def reset_password(user)
    setup_email(user)
    @subject += 'Reset password'
    @body[:url] = "#{SITE_URL}/account"
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email_with_name}"
      @from        = "server@onestoryroad.com"
      @subject     = "One Story Road - "
      @bcc         = "support@onestoryroad.com"
      @sent_on     = Time.now
      @body[:user] = user
    end
end
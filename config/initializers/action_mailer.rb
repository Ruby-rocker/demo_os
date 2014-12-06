ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.default_charset = "utf-8"
ActionMailer::Base.delivery_method = :smtp
#ActionMailer::Base.delivery_method = :sendmail

ActionMailer::Base.smtp_settings = {
  :address        => "smtp.gmail.com",
  :port           => 587,
  :domain         => "gmail.com",
  :user_name      => "server@onestoryroad.com",
  :password       => "Cal3bsSt0ry!#%&(",
  :authentication => :plain,
  :enable_starttls_auto => true
}

class Notifier < ActionMailer::Base
  
	def contact_message(contact)
		recipients 'info@onestoryroad.com'
		from contact.email
    bcc "caleb@onestoryroad.com"
		subject 'Website Contact Inquiry'
		content_type 'text/html'
		body :name => contact.name, :email => contact.email, :message => contact.message
	end

  def report_message(report)
    recipients 'report@onestoryroad.com'
    from report.email
    bcc "caleb@onestoryroad.com"
    subject 'Website Report Content'
    content_type 'text/html'
    body :name => report.name, :email => report.email, :message => report.message
  end
	
	def referral_message(referral)
		recipients referral.friend_email
		from referral.email
		subject 'Story Recommendation'
		body :referral => referral
	end
	
  def buzz_received(buzz)
    recipients buzz.to.email
    from "server@onestoryroad.com"
    bcc "support@onestoryroad.com"
    subject 'Your have been buzzed!'
    body :msg => buzz.body, :from_login => buzz.from.login
  end
  
end

class ContactsController < ApplicationController
  
  def index
    @contact = Contact.new
  	add_assests
  end

  def create
  	@contact = Contact.new(params['contact'])
    flash[:notice] = ''
    if @contact.save
    	begin
        Notifier.deliver_contact_message(@contact)
        notify_user
      rescue
        flash[:notice] = 'Sorry there was an unexpected error while sending your email. Please try again.'
        redirect_to '/contact/'
  	  end
    else
      flash[:notice] = 'Your message was not sent.<br/>Please make sure the form is completely filled out.'
      add_assests
      render :action => 'index'
    end
  end
  
  def notify_user
    flash[:notice] = '<b>Thank You!</b><br/>You\'ll be hearing from us!'
		redirect_to '/contact'
  end
  
  private
  
  def add_assests
    @stylesheet = [ 'pages/contact' ]
    @javascript = [ 'libs/autogrow' ]
  end

end
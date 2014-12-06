class ReferralsController < ApplicationController
  
  def create
  	@referral = Referral.new(params['referral'])
    flash[:notice] = ''
    if @referral.save
    	#begin
        Notifier.deliver_referral_message(@referral)
        flash[:notice] = '<b>Your message has been sent!</b><br/>Thanks for spreading the word!'
      #rescue
      #  flash[:notice] = 'Sorry there was an unexpected error while sending your email. Please try again.'
  	  #end
    else
      flash[:notice] = 'Your message was not sent.<br/>Please make sure the form is completely filled out.'
    end
    redirect_to @referral.referring_url
  end
  
end

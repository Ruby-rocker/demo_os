class ReportsController < ApplicationController
  
  def index
    @report = Report.new
    add_assests
  end

  def create
   # abort
    @report = Report.new(params['report'])
    flash[:notice] = ''
    if @report.save
      begin
        Notifier.deliver_report_message(@report)
        notify_user
      rescue
        flash[:notice] = 'Sorry there was an unexpected error while sending your email. Please try again.'
        redirect_to '/report/'
      end
    else
      flash[:notice] = 'Your message was not sent.<br/>Please make sure the form is completely filled out.'
      add_assests
      render :action => 'index'
    end
  end
  
  def notify_user
    flash[:notice] = '<b>Thank You!</b><br/>You\'ll be hearing from us!'
    redirect_to '/report/'
  end
  
  private
  
  def add_assests
    @stylesheet = [ 'pages/report' ]
    @javascript = [ 'libs/autogrow' ]
  end

end

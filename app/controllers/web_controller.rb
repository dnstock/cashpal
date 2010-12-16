class WebController < ApplicationController

  def unknown_request
    add_breadcrumb 'Page Not Found'
  end

  def company
    add_breadcrumb 'About Us'
  end

  def index
    # prevent someone loading cao.com/about/index (assuming that's equivalent to the root_url)
    redirect_to root_url unless params[:rooted]
  end

  def privacy
    add_breadcrumb 'Our Privacy Policy'
    @last_updated = 'July 3, 2009'
  end

  def terms
    add_breadcrumb 'Our Terms of Service'
    @last_updated = 'July 3, 2009'
  end

  def faq
    add_breadcrumb 'Frequently Asked Questions'
  end

  def sitemap
    add_breadcrumb 'Site Map for CashAddOn.com'
  end

  def download
    add_breadcrumb 'Download CashAddOn'
  end

  def firstrun
    add_breadcrumb 'Welcome to a world of savings'
  end

  def contact
    add_breadcrumb 'Write Us'
    if request.get? || params[:contact].blank?
      @contact = Contact.new
    else
      @contact = Contact.new(params[:contact])
      @contact.ip = request.remote_ip
      @contact.referer = request.referer
      @contact.user_agent = request.env['HTTP_USER_AGENT']
      @contact.request_uri = request.request_uri
      @contact.user_id = current_user && current_user.id
      if @contact.save
        @sent = true
        @contact = Contact.new
      else
        @errors = @contact.errors
        @subject_error = @errors[:subject].blank? ? '' : 'error'
      end
      render :partial => 'contact_form'
    end
  end
  
end

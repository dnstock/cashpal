# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  #helper :all # include all helpers, all the time
  helper :web

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '52015d834a9589e9da29412f1fbfc8b4'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user, :file_exists?, :user_cashback_summary

  add_breadcrumb 'Home', :root_path

  def dev_puts(msg)
    puts(msg) if ENV["RAILS_ENV"].eql?("development")
  end

  def file_exists?(filename)
    FileTest.file?( RAILS_ROOT + filename )
  end

  # Get rid of all non ascii characters.
  def stripped(string)
    string.chars.gsub(/[^\x20-\x7E]/, '')
  end

  private

    # Email validator that adheres directly to the specification for email address naming.
    # It allows for everything from ipaddress and country-code domains, to very rare characters in the username.
    def validate_email(email)
      #^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$
      # accepts RFC 2822 email addresses:
      #^((?>[a-zA-Z\d!#$%&'*+\-/=?^_`{|}~]+\x20*|"((?=[\x01-\x7f])[^"\\]|\\[\x01-\x7f])*"\x20*)*(?<angle><))?((?!\.)(?>\.?[a-zA-Z\d!#$%&'*+\-/=?^_`{|}~]+)+|"((?=[\x01-\x7f])[^"\\]|\\[\x01-\x7f])*")@(((?!-)[a-zA-Z\d\-]+(?<!-)\.)+[a-zA-Z]{2,}|\[(((?(?<!\[)\.)(25[0-5]|2[0-4]\d|[01]?\d?\d)){4}|[a-zA-Z\d\-]*[a-zA-Z\d]:((?=[\x01-\x7f])[^\\\[\]]|\\[\x01-\x7f])+)\])(?(angle)>)$
    end

#    def user_cashback_summary
#      @user_cashback_summary ||= UserCommissionSummary.find(
#        :first,
#        :conditions=>['user_id = ?', current_user.login])
#    end

    def user_cashback_summary
      @user_cashback_summary = UserCommissionSummary.find(
        :first,
        :conditions=>['user_id = ?', current_user.login]) || UserCommissionSummary.new
    end

    def current_user_session
      @current_user_session ||= UserSession.find
    end

    def current_user
      @current_user ||= current_user_session && current_user_session.user
    end
    
    def require_addon_password
      unless current_user
        store_location
        redirect_to :controller=>:addon, :action=>:verify_password 
        return false
      end
    end
    

    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to user_sessions_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to root_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

end

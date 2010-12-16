class AddonController < ApplicationController

  before_filter :require_addon_password, :only=>:account
  before_filter :require_user, 
    :except => [ :feedback, :register,:login, :about, :invisible_validate_user, :cookie_test,
                 :invalid_userid, :validate_user, :refresh_merchants, :refreshMerchants, :verify_password, :login_success]
  
  layout 'addon' #, :except=>[ :refreshMerchants ]
  
  def verify_password
    # dev_puts current_user.login
    # dev_puts params[:login]
    if current_user && current_user.login.eql?(params[:login])
      redirect_to :action=>:account
    else
      if request.get?
        @user_session = UserSession.new      
      elsif request.post?
        @user_session = UserSession.new(params[:user_session])
        if @user_session.save
          redirect_to :action=>:account
        else
          flash[:notice] = '<b>Incorrect password - Please try again</b>'
        end
      end
      #render :template=>'user_sessions/new'
    end
  end

  def refreshMerchants
    redirect_to addon_url(:refresh_merchants)
  end

  def refresh_merchants
    @merchants = Merchant.find :all, :order => "merchantName"
    render :layout => 'json'
    # @merchants_json = 
    # render :json => @merchants.to_json() # :only => :name
  end

  def authorize
    unless session[:found_user_id]
       flash[:notice]= "Please log in."
       redirect_to(:controller=>'addon',:action=>'invisible_validate_user')
    end
  end

  def account
    #if session[:found_user_id] then
      @user = User.find_user(current_user.login) # session[:found_user_id]
      @show_balance_info_in_addon = @user.show_balance_info_in_addon
      
      @is_site_admin = @user.is_site_admin
      if @user.show_balance_info_in_addon.eql?('Y')
        @user_commission_summary = User_Commission_Summary.find(
            :first, 
            :conditions=>['user_id=?', @user.login]) || User_Commission_Summary.new
      end
      if @is_site_admin.eql?('Y')
        @res = User_Commission_Summary.connection.select_one("select count(*) as nru from users")
        @res1 = User_Commission_Summary.connection.select_one("select count(distinct client_id) as no from client_installations")
      end
#    else
#      flash[:errors]=" user id not found - please enter another or sign up for a new one"
#      redirect_to(:controller=>'addon',:action=>'validate_user')
#    end
  end
  
  def feedback
    if request.get?
      @feedback = Feedback.new
    else
      @feedback = Feedback.new(params[:feedback])
      @feedback.user_id = params[:feedback][:user_id]
      dev_puts @feedback
      dev_puts params
      if @feedback.save
        @feedback = Feedback.new
        flash[:notice] = "Thank you for your feedback!"
        if defined? params[:nextURL]
          redirect_to params[:nextURL]
        end
      else
        flash[:notice] = "Please correct errors above."
      end
    end
  end
  

  def login
    if request.get?
      #session[:authenticated_user] = nil
      #@users = User.new
      #redirect_to_index("Login fields empty.")
    else 
      @users = User.new(params[:users])
      authenticated_user = @users.login_attempt
      if authenticated_user 
        session[:authenticated_user] = authenticated_user
        redirect_to(:controller => 'addon' , :action => 'login_success')
      else
        flash[:notice] = "Invalid login attempt."
        redirect_to(:controller => 'addon' , :action => 'login')
      end
    end
  end

  def invisible_validate_user
    if request.get?
      #session[:authenticated_user] = nil
      #@users = User.new
      #redirect_to_index("Login fields empty.")
    else 
      # @users = User.new(params[:users])
      # found_user = @users.find_user_attempt
      if current_user 
        session[:found_user_id] = found_user.login
        redirect_to(:controller => 'addon' , :action => 'account')
      else
        redirect_to(:controller => 'addon' , :action => 'verify_password')
      end
    end
  end

  def validate_user
    if request.get?
      #session[:authenticated_user] = nil
      #@users = User.new
      #redirect_to_index("Login fields empty.")
    else 
      @users = User.new(params[:users])
      found_user = @users.find_user_attempt
      if found_user 
        session[:found_user_id] = found_user.login
        redirect_to(:controller => 'addon' , :action => 'login_success')
      else
        flash[:errors]="specified user does not exist"
        redirect_to(:controller => 'addon' , :action => 'validate_user')
      end
    end
  end

  def invalid_userid
    
  end

  def register
    if request.get?
      @users = User.new
### The following code is no longer used, the addon/register page has a form that goes to /users (method=>post) and the UsersController
### actually creates the user and redirects the user to the correct page      
#    else
#      @users = User.new(params[:users])
#      password = @users.password  #we need this for the logging in after saving below
#      if @users.save
#        dev_puts "user registered"
#        @users.password = password #password would have been cleared out by the 'after_create' of users
#        password = nil
#        authenticated_user = @users.login_attempt
#        if authenticated_user 
#          session[:found_user_id] = authenticated_user.login
#          flash[:notice] = "Welcome " + @users.login + "! Your registration is complete and you are logged into the system."
#          send_signup_email(@users)
#          redirect_to(:controller => 'addon' , :action => 'register_success')
#        else
#          dev_puts "couldn't login after registering"
#        end
#      else
#        dev_puts "Couldn't save"
#        flash[:notice_add_user] = "Please correct the errors below."
#      end
    end
  end

  def about
    @today = Date.today
    user_id = params[:user_id]  
    client_id = params[:client_id]
    
    @ci = ClientInstallation.find(:first,:conditions => ["user_id = ? and client_id = ?",user_id,client_id]) 
#    dev_puts @ci || 'nil'
    if not @ci
      @ci = ClientInstallation.new({'user_id'=>user_id, 'client_id'=>client_id})
      begin
        @ci.save!
      rescue Exception => e
        dev_puts e
        dev_puts e.backtrace
      end
    end
  end

  def register_success
    @username = session[:found_user_id]
  end
  
  def login_success
    @username = session[:found_user_id]
  end
  
  
end

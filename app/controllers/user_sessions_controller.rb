class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  layout "web"
  
  def show
    add_breadcrumb 'Login'
    @login = UserSession.new
    render :action => :new
  end

  def new
  end
  
  # login
  def create
    add_breadcrumb 'Login'
    @login = UserSession.new(params[:user_session])
    if @login.save
      dev_puts "Login successful!"
      #flash[:notice] = "Login successful!"
      redirect_back_or_default root_url
    else
      render :action => :new
    end
  end

  # logout
  def destroy
    # dev_puts "user_sessions.destroy"
    current_user_session.destroy
    #flash[:notice] = "Logout successful!"
    redirect_to root_url
  end
  
  def index
    redirect_back_or_default :controller=>:web
  end

end

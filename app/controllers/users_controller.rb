class UsersController < ApplicationController
  # before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]

  # GET /users
  # GET /users.xml
#  def index
#    @users = User.find(:all)
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @users }
#    end
#  end

  # GET /users/1
  # GET /users/1.xml
#  def show
#    @user = User.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @user }
#    end
#  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @user }
#    end
  end

#  # GET /users/1/edit
#  def edit
#    @user = User.find(params[:id])
#  end

  # POST /users
  # POST /users.xml

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      password = @user.password
      if @user.save
        flash[:notice] = 'Registration successful.'
        
        dev_puts "user registered"
        # @user.password = password #password would have been cleared out by the 'after_create' of users
        user_session = UserSession.new
        user_session.login=@user[:login]
        user_session.password=password
        
        if user_session.save
          session[:found_user_id] = user_session.login
          flash[:notice] = "Welcome " + @user.login + "! Your registration is complete and you are logged into the system."
          send_signup_email(@user)
          # redirect_to(:controller => 'addon' , :action => 'register_success')
        else
          dev_puts "couldn't login after registering"
        end
        
        format.html { redirect_to({:controller=>:addon, :action=>:register_success}) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :template=>"addon/register" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
#  def update
#    @user = User.find(params[:id])
#
#    respond_to do |format|
#      if @user.update_attributes(params[:user])
#        flash[:notice] = 'User was successfully updated.'
#        format.html { redirect_to(@user) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
#      end
#    end
#  end

  # DELETE /users/1
  # DELETE /users/1.xml
#  def destroy
#    @user = User.find(params[:id])
#    @user.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(users_url) }
#      format.xml  { head :ok }
#    end
#  end
  
  private
  def send_signup_email(users)
    email = nil
    begin
      #dev_puts users.email
      email = SignupMailer.create_signup(users)
      email.set_content_type("text/html")
      SignupMailer.deliver(email)
    rescue
      #continue, don't do anything
        
    end
    @delivered_email = DeliveredEmail.new({"rctp_email" => users.email, "email_msg" => email})
    if not @delivered_email.save
      #email was not delivered and couldn't be saved to the db
    end

  end
end

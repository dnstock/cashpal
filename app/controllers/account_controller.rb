class AccountController < ApplicationController
#  helper :application
  
  before_filter :require_user #, :except => [:updateEmail,:updatePassword]
  layout "web", :except => [:updateEmail,:updatePassword,:update_payment_email,:leftnavbox,:update_show_balance_in_addon]

  add_breadcrumb 'Account', '/account'

  def profile
    add_breadcrumb 'Update My Profile'
  end

  def overview
    add_breadcrumb 'Overview'
  end
  
  def request_payment
    @user = current_user
    #@user = User.find_user('jonf')
    if not (@user.payment_email and @user.payment_email.length > 0) then
      flash[:notice] = "Please specify a PayPal email before requesting a payment."
      redirect_to :controller => "account", :action => "update"
    end
    if request.get?
      @user_commission_summary = User_Commission_Summary.find(
            :first, 
            :conditions=>['user_id = ?', @user.login]) || User_Commission_Summary.new
      
    else 
      dev_puts params
      @user_commission_summary = User_Commission_Summary.find(
            :first, 
            :conditions=>['user_id = ?', @user.login]
#            ,:order=>"row_id desc"
            )  || User_Commission_Summary.new
      @payment_request = Payment_Request.new
      @payment_request_amount = ApplicationHelper.to_number(params[:payment_request])
      @payment_provider = params[:payment_provider]
      
      dev_puts @payment_provider
      
      if @payment_request_amount 
        if @payment_request_amount <= ( @user_commission_summary.available || 0 )
          if @payment_request_amount > 10 
            begin
              User_Commission_Summary.transaction(@user_commission_summary) do
                @user_commission_summary.available = (@user_commission_summary.available - @payment_request_amount)
                @payment_request.user_id = @user.login
                @payment_request.payment_email = @user.payment_email
                @payment_request.amount = @payment_request_amount
                @payment_request.payment_provider = @payment_provider
                @user_commission_summary.save!
                @payment_request.save!
                flash[:notice] = "Payment has been scheduled successfully."
              end
            rescue
              flash[:errors] = "System error occurred while processing payment."
            end
          else
            flash[:errors] = "Minimum payment amount is $10.00."
          end
        else
          flash[:errors] = "Payment amount cannot exceed available funds."
        end
      else
        flash[:errors] = "Payment amount must be greater than or equal to 10 dollars and must not exceed available funds."
      end
    end
  end
  
  def zeropad_number(n)
    s = ""
    if n < 10 
      s = "0" + n.to_s
    else
      if n 
        s = n.to_s
      else
        s = ""
      end
    end
    return s
  end
  
  def cashback
    add_breadcrumb 'Summary of Cash Back'
    user_id = current_user.login
    if !params[:month_to_view]
      today = Date.today
      if today.month < 10 then
         month_to_view = today.year.to_s + "0" + today.month.to_s
      else
         month_to_view = today.year.to_s + today.month.to_s
      end
      params[:month_to_view]=month_to_view
    end

    month_to_view=params[:month_to_view]
#    dev_puts month_to_view

    year = month_to_view[0,4].to_i
    month = month_to_view[5,6].to_i

    whereStr = "user_id='" + user_id + "' and date >= str_to_date('" + year.to_s + "-" + zeropad_number(month) + "-01','%Y-%m-%d')"

    if month == 12 then
      #month = 1
      year2 = year + 1
      whereStr = whereStr + " and date < str_to_date('" + year2.to_s + "-01-01','%Y-%m-%d')"
    else
      #dev_puts 'got to here'
      #month = month + 1
      #dev_puts month.to_s + ":" + year.to_s
      month2=month+1
      whereStr = whereStr + " and date < str_to_date('" + year.to_s + "-" + zeropad_number(month2) + "-01','%Y-%m-%d')"
    end

#    @user_transactions_pending = User_Transaction.find(
#          :all,
#          :conditions=>whereStr + " and status='PENDING'",
#          :order=>" date asc ")

    @user_transactions_pending = User_Transaction.find(
          :all,
          :conditions=>whereStr + " and ut.status='PENDING' and ut.store_id = s.id ",
          :order=>" ut.date asc ",
          :joins =>"ut, stores s",
          :select => "ut.*") || User_Transaction.new

    @user_transactions_earned = User_Transaction.find(
          :all,
          :conditions=>whereStr + " and status='EARNED' and ut.store_id = s.id ",
          :order=>" date asc ",
          :joins =>"ut, stores s",
          :select => "ut.*") || User_Transaction.new
  end

  def update
  
  end

  def update_password
    if request.get?
      
    else
      tf_oldpassword = params[:tf_oldpassword]
      tf_password = params[:tf_password]
      tf_password2 = params[:tf_password2]

      if current_user then
        @users = current_user
        if @users.check_password_attempt(tf_oldpassword)
          @users.password = tf_password
          @users.password2 = tf_password2
          dev_puts "password1 " || @users.password || " password2: " || @users.password2
          if @users.save
            @output_message = "password changed successfully"
          else
            @error_messages = "please correct entries and try again"
          end
        else
          @error_message_old_password = "incorrect password entered"
        end
      else
        render(:nothing=>true, :status=>403)
      end
    end
  end
  
  def update_email
    if current_user
      @users = current_user
      if request.get?
        params[:tf_newemail]="new email address"
      else
        user_to_update = User.find(@users.id)
        newemail = params[:tf_newemail]
        if not newemail.eql?("new email address")
          begin  
            if newemail.match(/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i) and user_to_update.update_attribute(:email,newemail)
                @output = "updated successfully"
                current_user = user_to_update
                @users = user_to_update
                params[:tf_newemail]="new email address"
            else
              @error_message_newemail = "invalid entry"
              @output_error = "please correct errors and try again"
            end
          rescue
            @output_error = "this email has already been registered, please select another"
          end
        end
      end
    else
      render(:nothing=>true, :status=>403)
    end
  end
  
  def update_payment_email
    if current_user
      @users = current_user
      if request.get?
        params[:tf_newpaymentemail]="new email address"
      else
          user_to_update = User.find(@users.id)
          newpaymentemail = params[:tf_newpaymentemail]
          if not newpaymentemail.eql?("new email address")
            #dev_puts newemail.match(/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i)
            if newpaymentemail.match(/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i) and user_to_update.update_attribute(:payment_email,newpaymentemail)
                @output = "updated successfully"
                current_user = user_to_update
                @users = user_to_update
                params[:tf_newpaymentemail]="new email address"
#              else
#                @output = "please correct errors and try again"
#              end
            else
              @error_message_newpaymentemail = "invalid entry"
              @output_error = "please correct errors and try again"
            end
          end
        
      end
    else
      render(:nothing=>true, :status=>403)
    end
  end
  
  def update_show_balance_in_addon
    if current_user
      @users = current_user
      if request.get?
        params[:showBalanceInAddonFlag]=@users.show_balance_info_in_addon
      else
          user_to_update = User.find(@users.id)
          if params[:showBalanceInAddonFlag] and params[:showBalanceInAddonFlag].eql?('Y') then
            showBalanceInAddonFlag = 'Y'
          else
            showBalanceInAddonFlag = 'N'
          end
          
          user_to_update.show_balance_info_in_addon = showBalanceInAddonFlag;
        
          if user_to_update.update_attribute(:show_balance_info_in_addon,showBalanceInAddonFlag)
              @output = "updated successfully"
              current_user = user_to_update
              @users = user_to_update
              params[:showBalanceInAddonFlag]=showBalanceInAddonFlag
          end
        
      end
    else
      render(:nothing=>true, :status=>403)
    end
  end
end

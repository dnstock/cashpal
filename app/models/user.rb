class User < ActiveRecord::Base
  acts_as_authentic 
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    
    email = nil
    begin
      #dev_puts users.email
      email = SignupMailer.create_forgot_password_email(self)
      email.set_content_type("text/html")
      SignupMailer.deliver(email)
    rescue
      
    end
    @delivered_email = DeliveredEmail.new({"rctp_email" => self.email, "email_msg" => email})
    if not @delivered_email.save
      #email was not delivered and couldn't be saved to the db
    end
    # SignupMailer.deliver_forgot_password_email(self)
  end

  def self.find_user (login)
    find(:first,:conditions => ["login = ?",login]) 
  end
  
  def find_user_attempt
    User.find_user(self.login)
  end
end

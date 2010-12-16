class SignupMailer < ActionMailer::Base
  

  def signup(users)
    @subject    = 'Welcome to CashAddOn'
    @body['users'] = users
    @recipients = users.email
    @from       = 'CashAddOn <info@cashaddon.com>'
    @sent_on    = Time.now
    @headers    = {}
  end
  
  def forgot_password_email(user)
    subject    'CashAddOn: New Password Instructions'
    body       :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
    recipients user.email
    from       'CashAddOn Password <forgotpassword@cashaddon.com>'
    sent_on    Time.now
    headers    {}
  end
  
  def disable_email(recipient)
    @subject    = 'Important Notice to CashAddOn Users'
    #@body['users'] = users
    @recipients = recipient
    @from       = 'Cashaddon <info@cashaddon.com>'
    @sent_on    = Time.now
    @headers    = {}
  end
end

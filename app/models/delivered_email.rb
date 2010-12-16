class DeliveredEmail < ActiveRecord::Base
  set_primary_key "row_id"
  
  attr_accessible :rctp_email, :email_msg
  

  def before_insert
    self.email_attempt_ts = Time.now    
  end
end


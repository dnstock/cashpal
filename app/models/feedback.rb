class Feedback < ActiveRecord::Base
  require "erb"
  include ERB::Util
  attr_accessible :msg_subject,:rating,:message,:browser,:os, :client_id
  
#  def validate
#    @user = Users.find_user(self.user_id)
#    if !@user then
#      errors.add(:user_id,"User ID not found.")
#    end
#  end
#  
  
  def before_update
    self.msg_subject = sanitize(self.msg_subject)
    self.message = sanitize(self.message)
  end
  
  def before_create
    self.msg_subject = sanitize(self.msg_subject)
    self.message = sanitize(self.message)
    self.msg_timestamp = Time.now
  end
  
  private
  def sanitize(msg)
    return h(msg)
  end
end

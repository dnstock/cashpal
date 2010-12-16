class ClientInstallation < ActiveRecord::Base
   require "erb"
   include ERB::Util
  
   set_primary_key 'row_id'
   
   attr_accessible :user_id, :client_id
   
   def before_insert
      self.ts = Time.now
      self.user_id = h(user_id)
      self.client_id = h(user_id)
   end
end

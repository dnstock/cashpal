class Store < ActiveRecord::Base
  has_many :links
  
  def get_commission_detail_string
    s = ""
    var_display_commission_comment_string = ""
    if self.display_commission_comment_string and self.display_commission_comment_string.length > 0
      var_display_commission_comment_string = self.display_commission_comment_string
    else
      var_display_commission_comment_string = "on purchases"
    end
    if self.display_commission_to_users  
      s = ("Get <b>" + self.display_commission_to_users + "</b> cash back " + var_display_commission_comment_string + " at "+ self.name) || ""
    end
    
    return s
  end
end

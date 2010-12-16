class Link < ActiveRecord::Base
  belongs_to :store,
             :class_name => "Store",
             :foreign_key => "store_id"
  
  def self.per_page
      10
  end
  
  
  def self.getStoreLinks    
    links = Link.find(:all, :include => :store, :conditions => "links.link_type='STORELINK' and stores.is_active='Y' and stores.is_disabled='N' ", :order => "stores.name")
  end
  
  def self.getStoreLinks(startLetter)    
    links = Link.find(:all, :include => :store, 
      :conditions => "links.link_type='STORELINK' and stores.is_active='Y'  and stores.is_disabled='N' and substring(stores.name,1,1)='"+startLetter+"'", :order => "stores.name")
  end
  
  def self.getDistinctStoreNameFirstChar
    storeNameFirstChar = Link.find(
              :all, 
              :joins => " left join stores on links.store_id=stores.id ",
              :select => "distinct substr(stores.name,1,1) as letter",
              :conditions => "links.link_type='STORELINK' and stores.is_active='Y' and stores.is_disabled='N' ", 
              :order => "substr(stores.name,1,1)")

  end
 
  def self.getDistinctStoreCategories
    distinctStoreCategories = Link.find(
              :all, 
              :joins => " left join stores on links.store_id=stores.id ",
              :select => "distinct stores.category",
              :conditions => "links.link_type='STORELINK' and stores.is_active='Y' and stores.is_disabled='N' ", 
              :order => "stores.category")
  end
   
  def get_link_url(session_auth_user)
    retVal = self.link_url;
    if session_auth_user and session_auth_user.user_id
      if self.store.affiliate_type.casecmp('LinkShare') == 0 
        retVal = retVal.concat("&u1=".concat(session_auth_user.user_id))
      elsif self.store.affiliate_type.casecmp('CommissionJunction')  == 0
        if self.store_id == 96 or self.store_id == 100 or self.store_id==768
          #buy.com and ebay.com are special cases
          retVal = retVal.concat("&SID=".concat(session_auth_user.user_id))
        else
          retVal = retVal.concat("?SID=".concat(session_auth_user.user_id))
        end
      elsif self.store.affiliate_type.casecmp('Amazon') == 0
        retVal = retVal;
      elsif self.store.affiliate_type.casecmp('eBay') == 0
        retVal = retVal.concat("&customid=".concat(session_auth_user.user_id))
      end
    end    
  
    return retVal; 
  end 
  
end

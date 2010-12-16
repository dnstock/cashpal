ActionController::Routing::Routes.draw do |map|
  # Homepage
  map.root :controller => 'web', :rooted => true

  # Website content-related Controllers
  map.tour 'tour/:action',  :controller => 'tour', :action=>'what'
  #map.resource :contact, :as => 'about/contact', :only => [:create, :show]
  map.with_options :controller => 'web' do |c|
    c.web      'about/:action'
    c.download 'download',      :action => 'download'
    c.help     'about/faq',     :action => 'faq'      # move to help section url (/support/faq) once complete
    c.contact  'about/contact', :action => 'contact'  # move to help section url (/support/contact) once complete
    c.firstrun 'welcome/firstrun', :action => 'firstrun'
#    c.sitemap  'sitemap',       :action => 'sitemap'
  end

  # Shopping Controller (also handles searches)
  #   Searches are integrated into these urls via the 'keyword' GET variable
  #   ex: /cashback?keyword=asus+netbook -or- /deals?keyword=asus+netbook
  #       then only stores or deals, respectively, containing 'asus netbook' will be displayed
  #   This does not apply to tags, just stores, coupon and deals
  map.with_options :controller => 'shopping' do |c|
    c.shopping 'cashback/:slug', :action=>'shopping', :slug => nil
    c.tag      'tags/:name',     :action=>'tags',     :name => nil
    c.deal     'deals',          :action=>'specials', :type => 'Deal'
    c.coupon   'coupons',        :action=>'specials', :type => 'Coupon'
  end

  # User-related Controllers
  map.resource :user_sessions, :as => 'login', :only => [:create, :show]
  map.logout   'logout',          :controller=>'user_sessions',   :action=>'destroy'
  map.forgotpw 'login/forgot',    :controller=>'password_resets', :action=>'new'
  map.resetpw  'login/reset',     :controller=>'password_resets', :action=>'edit'
  map.account  'account/:action', :controller=>'account',         :action=>'overview'

  # Redirect Controller
  #   this is used to |redirect| website links to affiliate sites w/CAO ref ids
  map.with_options :controller => 'shopping' do |c|
    c.redirect_store  'click/store/:slug',  :action => 'click', :type => 'affiliate'
    c.redirect_deal   'click/deal/:slug',   :action => 'click', :type => 'deal'
    c.redirect_coupon 'click/coupon/:slug', :action => 'click', :type => 'coupon'
  end

  # Addon Controller
  map.addon 'addon/:action', :controller=>'addon'

##########-The /admin section is now in its own app-##########
#  # these are only used by admin for CRUD functions
#  map.namespace :admin do |admin|
#    admin.resources :affiliates, :networks, :deals, :coupons
    map.resources :users
#    #map.aggregator 'aggregator/:action', :controller=>'aggregator'
#  end

  # Catch-all: gracefully handle badly formed requests
  map.catchall "*anything", :controller => 'web', :action => 'unknown_request'

  # is this needed?
  # map.resources :client_installations

end

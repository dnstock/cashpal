class ShoppingController < ApplicationController
  # include Helper method for number_to_percentage
  include ActionView::Helpers::NumberHelper

  layout 'web'

  def shopping
    # Cash Back Shopping page
    unless( params[:slug] )
      add_breadcrumb 'Cash Back Shopping'
      @stores = Affiliate.find_stores
      @popular_stores = Affiliate.find_popular_stores
      # tag cloud
      @tags = Affiliate.is_active.tag_counts.sort_by(&:name)
      render :action => :shopping
    # individual store page
    else
      @store = Affiliate.find(params[:slug])
      # save view in database
      View.create(:resource_id => @store.id,
                  :resource_type => 'affiliate',
                  :resource_slug => params[:slug],
                  :ip => request.remote_ip,
                  :referer => request.referer,
                  :user_agent => request.env['HTTP_USER_AGENT'],
                  :request_uri => request.request_uri,
                  :user_id => current_user && current_user.id )
      add_breadcrumb 'Shopping', shopping_url
      add_breadcrumb @store.name
      @page_title = "Earn #{number_to_percentage(@store.cashback_to_user, :precision => 1)} cash back and get coupon codes, discounts and promo codes for #{@store.name}"
      @page_h1 = "Earn #{number_to_percentage(@store.cashback_to_user, :precision => 1)} cash back and get coupon codes, discounts and promo codes at #{@store.name}. With CashAddOn the savings is always at your fingertips."
      @meta_keywords    = @store.meta_keywords    unless @store.meta_keywords.blank?
      @meta_description = @store.meta_description unless @store.meta_description.blank?
      # tag cloud
      @tags = Affiliate.is_active.tag_counts.sort_by(&:name)
      render :action => :store
    end
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid cashback page, slug: #{params[:slug]}" )
      View.create(:failed => true,
                  :resource_type => 'affiliate',
                  :resource_slug => params[:slug],
                  :ip => request.remote_ip,
                  :referer => request.referer,
                  :user_agent => request.env['HTTP_USER_AGENT'],
                  :request_uri => request.request_uri,
                  :user_id => current_user && current_user.id )
      add_breadcrumb 'Page Not Found'
      render :template => 'web/unknown_request'
  end

  # deals & coupons
  def specials
    case params[:type]
    when 'Deal'
      type = Deal
      @h1_title    = 'Great deals plus cash back savings. Every day.'
      @h1_abstract = 'Get your stuff, save your cash. <br/>Simple. Shopping. Savings.'
    when 'Coupon'
      type = Coupon
      @h1_title    = 'Money Saving Coupons + Cash Back Savings'
      @h1_abstract = 'CashAddOn brings them together seemlessly. <br/>Simple. Shopping. Savings.'
    end
    add_breadcrumb 'Cash Back Shopping', shopping_url
    add_breadcrumb params[:type].pluralize
    @specials = type.find_newest_first
    deal_tags = Deal.is_active.tag_counts
    coupon_tags = Coupon.is_active.tag_counts
    @deal_coupon_tags = [deal_tags, coupon_tags].flatten.sort_by(&:name)
    @popular_stores = Affiliate.find_popular_stores
    @store_tags = Affiliate.is_active.tag_counts.sort_by(&:name)
  end

  def tags
    add_breadcrumb 'Tags', tag_url
    # Show tag clouds for all controllers
    unless( params[:name] )
      add_breadcrumb 'All Tags'
      @showall = true
      store_tags = Affiliate.is_active.tag_counts.sort_by(&:name)
      deal_tags = Deal.is_active.tag_counts.sort_by(&:name)
      coupon_tags = Coupon.is_active.tag_counts.sort_by(&:name)
      @all_tags = [store_tags, deal_tags, coupon_tags].flatten
    # Show stores and specials that match given tag
    else
      @showall = false
      tag = params[:name].gsub(/-/, ' ')
      add_breadcrumb tag
      @stores = Affiliate.tagged_with(tag, :on => :tags).is_active.sort_by(&:name)
      @deals = Deal.tagged_with(tag, :on => :tags).is_active.sort_by(&:created_at)
      @coupons = Coupon.tagged_with(tag, :on => :tags).is_active.sort_by(&:created_at)
    end
  end

  # this is a script that tracks & redirects the user to an off-site link
  def click
    type = case params[:type]
    when 'affiliate' then Affiliate
    when 'deal' then Deal
    when 'coupon' then Coupon
    end
    @rec = type.find(params[:slug])
    raise ActiveRecord::RecordNotFound unless @rec.is_active
    Click.create(:resource_id => @rec.id,
                 :resource_type => params[:type],
                 :resource_slug => params[:slug],
                 :redirect_url => @rec.link_redirect,
                 :ip => request.remote_ip,
                 :referer => request.referer,
                 :user_agent => request.env['HTTP_USER_AGENT'],
                 :request_uri => request.request_uri,
                 :user_id => current_user && current_user.id )
    redirect_to @rec.link_redirect
  rescue ActiveRecord::RecordNotFound
    logger.error("Failed redirect attempt type: #{params[:type]}, slug: #{params[:slug]}" )
    Click.create(:failed => true,
                 :resource_type => params[:type],
                 :resource_slug => params[:slug],
                 :ip => request.remote_ip,
                 :referer => request.referer,
                 :user_agent => request.env['HTTP_USER_AGENT'],
                 :request_uri => request.request_uri,
                 :user_id => current_user && current_user.id )
    add_breadcrumb 'Page Not Found'
    render :template => 'web/unknown_request'
  end

end
